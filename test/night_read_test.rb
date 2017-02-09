require 'minitest/autorun'
require 'minitest/pride'
require "./lib/night_read"

# If you want to run without arguments, comment out class instantiation at the bottom of night_read.rb
class NightReadTest < Minitest::Test
  attr_reader :nr
  def setup
    @nr = NightRead.new
  end
  
  def test_braille_to_english_class_exists
    # nr.instance_variable_set(:@reader, "0.\n..\n..")
    assert_instance_of NightRead, nr
  end
  
  def test_it_can_parse_a_letter_of_braille_into_lines
    nr.parse_braille_lines("0.\n..\n..") # 'a'
    assert_equal ["0.","..",".."], [nr.line_1, nr.line_2, nr.line_3] 
  end
  
  def test_it_can_parse_multiple_letters_of_braille_into_lines
    nr.parse_braille_lines("0..0\n000.\n....")  # "hi"
    assert_equal ["0..0","000.","...."], [nr.line_1, nr.line_2, nr.line_3] 
  end
  
  def test_it_can_access_a_braille_line
    nr.parse_braille_lines("0..0\n000.\n....") # "hi"
    assert_equal "0..0", nr.line_1
  end
  
  # nr.encode_to_braille("0..0\n000.\n....") "hi"
  
  def test_can_it_parse_a_braille_letter_into_groups_of_two_chars
    nr.parse_braille_lines("0.\n..\n..") # "a"
    assert_equal ["0."], nr.line_1_braille
  end
  
  def test_can_it_parse_a_braille_word_into_groups_of_two_chars
    nr.parse_braille_lines("0..0\n000.\n....") # "hi"
    assert_equal ["0.", ".0"], nr.line_1_braille
  end
  
  def test_it_returns_one_braille_alphabet_value
    nr.parse_braille_lines("0.\n..\n..") # "a"
    assert_equal ['0.','..','..'], nr.braille_letters[0]
  end
  
  def test_it_returns_two_braille_alphabet_values
    nr.parse_braille_lines("0..0\n000.\n....") # "hi"
    assert_equal [['0.','00','..'], ['.0','0.','..']], nr.braille_letters
  end
  
  def test_it_returns_two_words_of_braille_alphabet_values
    nr.parse_braille_lines("0..0..000.00\n000......0..\n......0.0.0.") # "hi mom"
    assert_equal [['0.','00','..'], ['.0','0.','..'], ['..','..','..'], ['00','..','0.'], ['0.','.0','0.'], ['00','..','0.']], nr.braille_letters
  end
  
  
  def test_it_returns_capital_letter_of_braille_alphabet_value
    nr.parse_braille_lines("..0.\n....\n.0..") # "caps a"
    assert_equal [['..','..','.0'], ['0.','..','..']], nr.braille_letters
  end
  
  def test_it_returns_english_letter
    nr.encode_to_english("0.\n..\n..") # "a"
    assert_equal ["a"], nr.english_letters
  end
  
  def test_it_returns_english_words_as_array_of_strings
    nr.encode_to_english("0..0..000.00\n000......0..\n......0.0.0.") 
    assert_equal ["h", "i", " ", "m", "o", "m"], nr.english_letters
  end
  
  def test_it_returns_english_words_as_a_single_string
    nr.encode_to_english("0..0..000.00\n000......0..\n......0.0.0.")
    assert_equal "hi mom", nr.make_single_string
  end
  
  def test_it_returns_english_capital_letter
    nr.encode_to_english("..0.\n....\n.0..") 
    assert_equal ["A"], nr.english_letters_final
  end
  
  def test_it_returns_capital_letters_symbols_lowercase_letters_as_single_string
    nr.encode_to_english("..0..0......0.0..0..0.0.0...000.0...\n..000.00....00.000....00.0...0.0..0.\n.0....0....0..0..0....0.....000.0000")
    assert_equal "Hi! How are you?", nr.make_single_string
  end
  
end