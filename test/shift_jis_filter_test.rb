require 'test/unit'
$LOAD_PATH << File.join(File.dirname(__FILE__), '..',  'lib')
require 'shift_jis_filter'

class Object
  def blank?; to_s.empty?; end
end

class ShiftJisFilterTest < Test::Unit::TestCase
  def setup
    @filter = ShiftJisFilter.new
    @controller = Struct.new(:response).new
    @controller.response = Struct.new(:body, :charset).new
  end

  def test_conversion
    { 
      "" => "",
      "\343\202\253" => "\203J",
    }.each do |initial, expected|
      @controller.response.body = initial
      @filter.after(@controller)
      assert_equal expected, @controller.response.body
    end
  end

  def test_charset
    { 
      "" => nil,
      "s" => "Shift_JIS",
    }.each do |initial, expected|
      @controller.response.body = initial
      @filter.after(@controller)
      assert_equal expected, @controller.response.charset
    end
  end
end
