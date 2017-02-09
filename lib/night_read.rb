require './lib/file_io.rb'
require './lib/braille_alphaneumeric'


class NightRead
  include BrailleAlphaneumeric
  attr_reader :file_io, :braille_alphabet, :english_letters, :braille_letters, :lines_parsed, :english_letters_final, :english
  attr_accessor :line_1, :line_2, :line_3, :line_1_braille, :line_2_braille, :line_3_braille
  
  def initialize
    @file_io = FileIO.new
    @braille_alphabet = BrailleAlphaneumeric.braille_alphabet
    @lines_parsed = []
    @line_1 = []
    @line_2 = []
    @line_3 = []
    @line_1_braille = []
    @line_2_braille = []
    @line_3_braille = []
    @braille_letters = []
    @english_letters = []
    @english_letters_final = []
  end
  
  def encode_file_to_english
    braille = file_io.read
    @english = encode_to_english(braille)
    file_io.write(english)
  end
  
  def encode_to_english(input)
    parse_braille_lines(input)
  end
  
  def parse_braille_lines(input)
    @line_1, @line_2, @line_3 = input.split(/\n/)
     parse_braille_letter_elements
  end
  
  def parse_braille_letter_elements
    @line_1_braille = line_1.scan(/../)
    @line_2_braille = line_2.scan(/../)
    @line_3_braille = line_3.scan(/../)
    # require "pry"; binding.pry

    i = 0
    until i > line_1_braille.length - 1
      @braille_letters << [line_1_braille[i], line_2_braille[i], line_3_braille[i]]
      i +=1
    end
    translate_to_english
  end
  
  def translate_to_english
    @english_letters = braille_letters.map do |letter|
      braille_alphabet.key(letter)
    end
    capitalize_letters
  end
  
  def capitalize_letters
    @english_letters.each_with_index do |character, i|
      if character == "caps"
        english_letters_final << english_letters[i + 1].upcase
        i += 2
      elsif @english_letters[i - 1] == "caps"
      elsif character == "#"
        i += 1
        translate_numbers(english_letters[i], i)
        i = new_i
      else
        english_letters_final << character
      end
    end
    make_single_string
  end
  
  def translate_numbers(english_letter, new_i)
    until english_letters[i] == " "
      english_number = braille_letters_to_numbers[english_letters[i]]
      english_letters_final << english_number
      @new_i += 1 ## need to work on this
      translate_numbers(english_letters[i], i)
    end
  end
  
  def make_single_string
    english_letters_final.join
  end
  
end

nr = NightRead.new 
nr.encode_file_to_english