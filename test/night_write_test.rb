gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/night_write"

class NightWriterTest < Minitest::Test
  attr_reader :nw
  def setup
    @nw = NightWriter.new
  end

  def test_does_NightRider_class_exist
    assert_instance_of NightWriter, nw
  end

  def test_new_baille_file_exists
    skip
    refute new_braille
  end
  
end
