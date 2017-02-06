# number_characters = File.read(ARGV[0]).length
# puts "Read '#{ARGV[0]}'; it contains #{number_characters} characters"
require './file_reader.rb'


class NightWriter
  attr_reader :file_reader, :confirmation

  def initialize
    @reader = FileReader.new
    @confirmation = confirmation
  end

  #limit char length!

  # braille = File.open(ARGV[1], 'w')
  # puts "Created '#{ARGV[1]}' containing 256 characters"


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

puts ARGV.inspect

alph = braille_alphabet.map do |letter|
  letter.each do |segment|
    puts segment
