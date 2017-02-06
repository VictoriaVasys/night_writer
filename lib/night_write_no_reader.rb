#require "../message"
class NightWriterNoReader
  attr_reader :message, :word
  attr_accessor :braille_alphabet
  def initialize
    @message = "hello me"
   
  end

  def parse
    message.split(//)  
  end

  # def translate_letter_to_braille
  #   braille_letter = braille_alphabet[message]
  #   braille_letter.join("\n")
  # end

  def translate_word_to_braille
    letters = parse
    braille_letter_array = letters.map do |letter|
      braille_alphabet[letter]
    end
    
    line_1 = []
    line_2 = []
    line_3 = []

    braille_letter_array.map do |letter|
      line_1 << letter[0]
      line_2 << letter[1]
      line_3 << letter[2]
    end

    line_1_single_string = line_1.join('')
    line_2_single_string = line_2.join('')
    line_3_single_string = line_3.join('')

    word = [line_1_single_string,line_2_single_string,line_3_single_string].join("\n")
  end

  def create_braille_file
    new_braille = File.open(braille.txt, "w")
    new_braille.write(word)
  end
  
  def braille_alphabet
    braille_alphabet = {
      "a" => ['0.','..','..'],
      "b" => ['0.','0.','..'],
      "c" => ['00','..','..'],
      "d" => ['00','.0','..'],
      "e" => ['0.','.0','..'],
      "f" => ['00','0.','..'],
      "g" => ['00','00','..'],
      "h" => ['0.','00','..'],
      "i" => ['.0','0.','..'],
      "j" => ['.0','00','..'],
      "k" => ['0.','..','0.'],
      "l" => ['0.','0.','0.'],
      "m" => ['00','..','0.'],
      "n" => ['00','.0','0.'],
      "o" => ['0.','.0','0.'],
      "p" => ['00','0.','0.'],
      "q" => ['00','00','0.'],
      "r" => ['0.','00','0.'],
      "s" => ['.0','0.','0.'],
      "t" => ['.0','00','0.'],
      "u" => ['0.','..','00'],
      "v" => ['0.','0.','00'],
      "w" => ['.0','00','.0'],
      "x" => ['00','..','00'],
      "y" => ['00','.0','00'],
      "z" => ['0.','.0','00'],
      "!" => ['..','00','0.'],
      "'" => ['..','..','0.'],
      "," => ['..','0.','..'],
      "-" => ['..','..','00'],
      "." => ['..','00','.0'],
      "?" => ['..','0.','00'],
      "caps" => ['..','..','.0'],
      " " => ['..','..','..']
    }
  end
end