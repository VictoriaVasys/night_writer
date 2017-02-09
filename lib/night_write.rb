require './lib/file_io.rb'
require './lib/braille_alphaneumeric'

class NightWrite
  include BrailleAlphaneumeric
  attr_reader :file_io, :braille_alphabet, :braille_letters_to_numbers, :braille_letter_array, :line_1, :line_2, :line_3, :parsed_letters, :all_lines
  attr_accessor :braille

  def initialize
    @file_io = FileIO.new
    @braille_alphabet = BrailleAlphaneumeric.braille_alphabet
    @braille_letters_to_numbers = BrailleAlphaneumeric.braille_letters_to_numbers
    @braille_letter_array = []
    @line_1 = []
    @line_2 = []
    @line_3 = []
  end

  def encode_file_to_braille
    plain = file_io.read
    @braille = encode_to_braille(plain)
    file_io.write(braille)
  end
  
  def encode_to_braille(input)
    parse_english_text(input)
  end
  
  def parse_english_text(input)
    @parsed_letters = input.split(//)
    translate_letters_to_braille
  end

  def translate_letters_to_braille
    parsed_letters.each_with_index.map do |letter, i|
      if /[[:alpha:]]/.match(letter) && letter.upcase == letter
        formats_caps(letter)
      elsif /[[:digit:]]/.match(letter)
        format_nums(letter, i)
      else
        braille_letter_array << braille_alphabet[letter]
      end
    end

    braille_letter_array.map do |letter|
      line_1 << letter[0]
      line_2 << letter[1]
      line_3 << letter[2]
    end
    format_lines
  end
  
  def formats_caps(letter)
    braille_letter_array << braille_alphabet["caps"] 
    braille_letter_array << braille_alphabet[letter.downcase]
  end
  
  def format_nums(letter, i)
    number_key = braille_letters_to_numbers.key(letter)
    if i != 0 && /[[:digit:]]/.match(parsed_letters[i - 1])
      braille_letter_array << braille_alphabet[number_key]
    else
      braille_letter_array << braille_alphabet["#"]
      braille_letter_array << braille_alphabet[number_key]
    end
  end

  def format_lines
    line_1_single_string = line_1.join('')
    line_2_single_string = line_2.join('')
    line_3_single_string = line_3.join('')
    @all_lines = [line_1_single_string, line_2_single_string, line_3_single_string]
    
    if line_1_single_string.length > 80
      format_long_lines
    else
      all_lines.join("\n")
    end
  end
  
  def format_long_lines
    extra_lines = []
    all_lines.map do |line|
      line[0..79]
      extra_lines << line[80..-1]
    end
    @all_lines += extra_lines
    all_lines.join("\n")
  end
end

nw = NightWrite.new
nw.encode_file_to_braille
