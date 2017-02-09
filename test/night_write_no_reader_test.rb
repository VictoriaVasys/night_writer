gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/night_write_no_reader"

class NightWriterNoReaderTest < Minitest::Test
  attr_reader :nwnr
  def setup
    @nwnr = NightWriterNoReader.new
  end
  def test_new_class_exits
    skip
    assert_instance_of NightWriterNoReader, nwnr
  end

  def test_it_takes_input
    skip
    nwnr = NightWriterNoReader.new("hello")
    assert_equal "hello", nwnr.message
  end

  def test_it_parses_string_into_letters
    skip
    nwnr("hello world")
    assert_equal ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], nwnr.parse
  end

  def test_it_can_translate_letter_into_Braille
    skip
    # nwnr("a")
    assert_equal "0.\n..\n..", nwnr.translate_letter_to_braille
  end

  def test_it_can_translate_word_into_Braille
    # nwnr("hello me")
    # nw = NightWriterNoReader.new("hello me")
    assert_equal "0.0.0.0.0...000.\n00.00.0..0.....0\n....0.0.0...0...", nwnr.translate_word_to_braille
  end

  def test_it_creates_braille_file
    skip
    nw = NightWriterNoReader.new
    create = nw.create_braille_file
    assert create
  end
end
