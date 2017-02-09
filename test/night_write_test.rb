require 'minitest/autorun'
require 'minitest/pride'
require "./lib/night_write"

# If you want to run without arguments, comment out class instantiation at the bottom of night_write.rb
class NightWriteTest < Minitest::Test
  attr_reader :nw
  def setup
    @nw = NightWrite.new
  end
  
  def test_it_exists
    assert_instance_of NightWrite, nw
  end
  
  def test_it_parses_string_into_letters
    nw.encode_to_braille("hello world")
    assert_equal ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], nw.parsed_letters
  end

  def test_it_can_translate_a_letter_into_braille
    assert_equal "0.\n..\n..", nw.encode_to_braille("a")
  end
  
  def test_it_can_translate_another_letter_into_braille
    assert_equal "0.\n0.\n..", nw.encode_to_braille("b")
  end
  
  def test_it_can_translate_a_symbol_into_braille
    assert_equal "..\n0.\n..", nw.encode_to_braille(",")
  end
  
  def test_it_can_translate_a_word_into_braille
    assert_equal "0..0\n000.\n....", nw.encode_to_braille("hi")
  end
  
  def test_it_can_translate_another_word_into_braille
    assert_equal "0.000.\n0..0.0\n..00..", nw.encode_to_braille("bye")
  end
  
  def test_it_can_find_capital_letter
    assert_equal [['..','..','.0'],['0.','..','..']], nw.formats_caps("A")
  end
  
  def test_it_can_find_capital_letter_and_translate_to_braille
    assert_equal "..0.\n....\n.0..", nw.encode_to_braille("A")
  end
  
  def test_it_can_translate_two_words_into_braille
    assert_equal "0.0.0.0.0...000.\n00.00.0..0.....0\n....0.0.0...0...", nw.encode_to_braille("hello me")
  end
  
  def test_it_can_translate_words_with_capitals_and_lower_case_and_symbols_into_braille
    assert_equal "..0..0......0.0..0..0.0.0...000.0...\n..000.00....00.000....00.0...0.0..0.\n.0....0....0..0..0....0.....000.0000", nw.encode_to_braille("Hi! How are you?")
  end

  def test_it_can_create_a_new_file 
    skip
    nw.encode_file_to_braille
    assert File.exists?("braille.txt")
    assert_equal "0.0.0.0.0...000.\n00.00.0..0.....0\n....0.0.0...0...", File.read("./braille.txt")
  end
  
  def test_it_can_split_long_braille_into_lines_of_80_characters
    nw.encode_to_braille("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    assert_equal "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n..................................................................................\n..................................................................................\n0.\n..\n..", nw.format_long_lines
  end
  
  def test_it_can_translate_numbers_to_braille
    assert_equal ".00.0000\n.00....0\n00......", nw.encode_to_braille("234")
  end
  
  def test_it_can_return_numbers_and_letters_to_braille
    assert_equal "0..0.....00.0000..\n000.00...00....000\n....0...00......0.", nw.encode_to_braille("hi! 234!")
  end 
end
