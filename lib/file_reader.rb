
# message = File.read(ARGV[0])
# braille = File.open(ARGV[1], 'w')
# 3.times {puts message}

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end
