gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/file_reader"

class FileReaderTest < Minitest::Test
  def setup
    @fr = FileReader.new
  end

  def test_does_it_read_a_file
    # this test need message.txt in file_reader.rb
    assert_equal "hello", @fr.read
  end
end