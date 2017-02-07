# number_characters = File.read(ARGV[0]).length
# puts "Read '#{ARGV[0]}'; it contains #{number_characters} characters"
require './lib/file_reader.rb'
require './lib/braille_alphabet'


class NightWriter
  include BrailleAlphabet
  attr_reader :file_reader, :confirmation, :file, :braille_alphabet

  def initialize
    @reader = FileReader.new
    @file = @reader.read
    @braille_alphabet = BrailleAlphabet.braille_alphabet
    # require "pry"; binding.pry
    @confirmation = confirmation # do we need this?
  end

  #limit char length!

  def parse
    file.split(//)
  end

  def formats_caps(braille_letter, english_letter)
   require "pry"; binding.pry
   # returns array with prepending
   if english_letter.upcase == english_letter
     braille_alphabet["caps"] + braille_letter
   else
     braille_letter
   end
   
  end

  # def translate_letter_to_braille
  #   braille_letter = braille_alphabet[message]
  #   braille_letter.join("\n")
  # end

  def translate_letters_to_braille
    braille_letter_array = parse.map do |letter|
      formats_caps(braille_alphabet[letter], letter)
    end

    line_1 = []
    line_2 = []
    line_3 = []

    braille_letter_array.map do |letter|
      line_1, line_2, line_3 = letter
    end
  end

  def format_lines
    format_lines([line_1, line_2, line_3])

    line_1_single_string = line_1.join('')
    line_2_single_string = line_2.join('')
    line_3_single_string = line_3.join('')

    [line_1_single_string,line_2_single_string,line_3_single_string].join("\n")
  end

  def create_braille_file
    new_braille = File.open(ARGV[1], "w")
    new_braille.write(translate_letters_to_braille)
    require "pry"; binding.pry
  end

  # def content_array
  def encode_file_to_braille
    # I wouldn't worry about testing this method
    # unless you get everything else done
    plain = reader.read
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(input)
    # you've taken in an INPUT string
    # do the magic
    # send out an OUTPUT string
  end
end

# puts ARGV.inspect
#
# alph = braille_alphabet.map do |letter|
#   letter.each do |segment|
#     puts segment
#   end
# end
