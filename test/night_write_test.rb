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
    assert nw
  end

  def test_does_it_output_string
    skip
    nw.read
    assert_equal message.txt, ARGV[0]
  end


end
