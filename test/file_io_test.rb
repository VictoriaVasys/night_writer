gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/file_io"

class FileIOTest < Minitest::Test
  attr_reader :fio
  def setup
    @fio = FileIO.new
  end

  def test_does_it_read_a_file
    assert_equal "hello me", fio.read # this test needs ARGV[0] == message.txt
  end
  
  def test_it_can_read_a_file_and_write_a_different_file_from_filename
    fio.write("0.0.0.0.0...000.\n00.00.0..0.....0\n....0.0.0...0...")
    assert_equal "0.0.0.0.0...000.\n00.00.0..0.....0\n....0.0.0...0...", File.read("./braille.txt")
  end

end