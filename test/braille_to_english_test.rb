require 'minitest/autorun'
require 'minitest/pride'
require "./lib/braille_to_english"

class BrailleToEnglishTest < Minitest::Test
  attr_reader :bte
  def setup
    @bte = BrailleToEnglish.new
  end
  
  def test_braille_to_english_class_exists
    # bte.instance_variable_set(:@reader, "0.\n..\n..")
    assert_instance_of BrailleToEnglish, bte
  end
  
  def test_it_can_parse_a_letter_of_braille_into_lines
    bte.parse_braille_lines("0.\n..\n..") # 'a'
    assert_equal ["0.","..",".."], [bte.line_1, bte.line_2, bte.line_3] 
  end
  
  def test_it_can_parse_multiple_letters_of_braille_into_lines
    bte.parse_braille_lines("0..0\n000.\n....")  # "hi"
    assert_equal ["0..0","000.","...."], [bte.line_1, bte.line_2, bte.line_3] 
  end
  
  def test_it_can_access_a_braille_line
    bte.parse_braille_lines("0..0\n000.\n....") # "hi"
    assert_equal "0..0", bte.line_1
  end
  
  # bte.encode_to_braille("0..0\n000.\n....") "hi"
  
  def test_can_it_parse_a_braille_letter_into_groups_of_two_chars
    bte.parse_braille_lines("0.\n..\n..") # "a"
    assert_equal ["0."], bte.line_1_braille
  end
  
  def test_can_it_parse_a_braille_word_into_groups_of_two_chars
    bte.parse_braille_lines("0..0\n000.\n....") # "hi"
    assert_equal ["0.", ".0"], bte.line_1_braille
  end
  
  def test_it_returns_one_braille_alphabet_value
    bte.parse_braille_lines("0.\n..\n..") # "a"
    assert_equal ['0.','..','..'], bte.braille_letters[0]
  end
  
  def test_it_returns_two_braille_alphabet_values
    bte.parse_braille_lines("0..0\n000.\n....") # "hi"
    assert_equal [['0.','00','..'], ['.0','0.','..']], bte.braille_letters
  end
  
  def test_it_returns_two_words_of_braille_alphabet_values
    bte.parse_braille_lines("0..0..000.00\n000......0..\n......0.0.0.") # "hi mom"
    assert_equal [['0.','00','..'], ['.0','0.','..'], ['..','..','..'], ['00','..','0.'], ['0.','.0','0.'], ['00','..','0.']], bte.braille_letters
  end
  
  
  def test_it_returns_capital_letter_of_braille_alphabet_value
    bte.parse_braille_lines("..0.\n....\n.0..") # "caps a"
    assert_equal [['..','..','.0'], ['0.','..','..']], bte.braille_letters
  end
  
  def test_it_returns_english_letter
    bte.encode_to_english("0.\n..\n..") # "a"
    assert_equal ["a"], bte.english_letters
  end
  
  def test_it_returns_english_words_as_array_of_strings
    bte.encode_to_english("0..0..000.00\n000......0..\n......0.0.0.") 
    assert_equal ["h", "i", " ", "m", "o", "m"], bte.english_letters
  end
  
  def test_it_returns_english_words_as_a_single_string
    bte.encode_to_english("0..0..000.00\n000......0..\n......0.0.0.")
    assert_equal "hi mom", bte.make_single_string
  end
  
  def test_it_returns_english_capital_letter
    bte.encode_to_english("..0.\n....\n.0..") 
    assert_equal ["A"], bte.english_letters_final
  end
  
  def test_it_returns_capital_letters_symbols_lowercase_letters_as_single_string
    bte.encode_to_english("..0..0......0.0..0..0.0.0...000.0...\n..000.00....00.000....00.0...0.0..0.\n.0....0....0..0..0....0.....000.0000")
    assert_equal "Hi! How are you?", bte.make_single_string
  end
  
  def test_it_writes_final_single_string_to_a_file
    bte.encode_file_to_english
  end
end