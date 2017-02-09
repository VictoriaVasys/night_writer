class FileIO
  def read
    filename = ARGV[0]
    File.read(filename)
  end
  
  def write(translation)
    filename = ARGV[1]
    new_braille = File.open(filename, "w")
    new_braille.write(translation)
    new_braille.close
    read_new = File.open(filename, "r")
    number_of_characters = read_new.read.length
    puts "Created '#{ARGV[1]}' containing #{number_of_characters} characters"
  end
end