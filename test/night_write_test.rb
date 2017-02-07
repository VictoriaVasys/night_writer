gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/night_write"

class NightWriterTest < Minitest::Test
  attr_reader :nw
  def setup
    @nw = NightWriter.new
  end
  
  def test_does_NightRider_class_exists
    assert_instance_of NightWriter, nw
  end

  def test_it_takes_a_file_from_command_line
    assert nw
    assert_equal String, nw.file.class
    assert_equal "hello world", nw.file
  end

  def test_it_takes_input
    assert_equal "hello world", nw.file
  end

  def test_it_parses_string_into_letters
    assert_equal ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], nw.parse
  end

  # def test_it_can_translate_letters_into_Braille
  #   nw = NightWriter.new
  #   # "a"
  #   assert_equal "0.\n..\n..", nw.translate_letters_to_braille
  # end
  
  def test_it_can_find_capital_letter
    assert_equal "H", nw.formats_caps(['0.','00','..'], "H")
  end
  
  def test_it_can_translate_letters_into_Braille
    skip
    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...", nw.translate_letters_to_braille
  end

  def test_it_creates_braille_file
    skip
    create = nw.create_braille_file
    assert create
  end

end
