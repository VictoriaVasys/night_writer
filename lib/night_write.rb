# number_characters = File.read(ARGV[0]).length
# puts "Read '#{ARGV[0]}'; it contains #{number_characters} characters"

message = File.read(ARGV[0])
braille = File.open(ARGV[1], 'w')
3.times {puts message}

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
    require "pry"; binding.pry
  end
end

class NightWriter
  attr_reader :file_reader, :confirmation

  def initialize
    @reader = FileReader.new
    @confirmation = confirmation
  end

  # braille = File.open(ARGV[1], 'w')
  # puts "Created '#{ARGV[1]}' containing 256 characters"


  # def content_array

end


