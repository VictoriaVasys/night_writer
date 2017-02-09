# number_characters = File.read(ARGV[0]).length
# puts "Read '#{ARGV[0]}'; it contains #{number_characters} characters"
require './lib/file_reader.rb'
require './lib/braille_alphaneumeric'


class NightWriter
  include BrailleAlphaneumeric
  attr_reader :file_reader, :braille_alphabet, :braille_letter_array, :reader, :line_1, :line_2, :line_3, :parsed_letters
  attr_accessor :braille

  def initialize
    @reader = FileReader.new
    @braille_alphabet = BrailleAlphaneumeric.braille_alphabet
    @braille_letter_array = []
    @line_1 = []
    @line_2 = []
    @line_3 = []
  end

  def encode_file_to_braille
    plain = reader.read
    @braille = encode_to_braille(plain)
    encode_braille_translation_to_file
  end
  
  def encode_to_braille(input)
    parse_english_text(input)
  end
  
  def parse_english_text(input)
    # read_file = reader.read
    @parsed_letters = input.split(//) # if trying to pass in a txt file, this needs to be assigned to the variable file_read
    translate_letters_to_braille
  end

  def translate_letters_to_braille
    parsed_letters.map do |letter|
      formats_caps(letter)
    end

    braille_letter_array.map do |letter|
      line_1 << letter[0]
      line_2 << letter[1]
      line_3 << letter[2]
    end
    format_lines
  end
  
  def formats_caps(letter)
   if /[[:alnum:]]/.match(letter) && letter.upcase == letter
     braille_letter_array << braille_alphabet["caps"] 
     braille_letter_array << braille_alphabet[letter.downcase]
   else
     braille_letter_array << braille_alphabet[letter]
   end
  end

  def format_lines
    
    line_1_single_string = line_1.join('')
    line_2_single_string = line_2.join('')
    line_3_single_string = line_3.join('')
     # Add "\n\n\n" after every 80th character
   
   if line_1_single_string.length > 80
     line_1_single_string
   end

    [line_1_single_string, line_2_single_string, line_3_single_string].join("\n")
  end
  
  def encode_braille_translation_to_file
    new_braille = File.open(ARGV[1], "w")
    new_braille.write(braille)
  end
end



# puts ARGV.inspect
