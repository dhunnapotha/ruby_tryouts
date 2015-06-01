# freeze

require 'test/unit'

class OtherRubyFunctionsTest < Test::Unit::TestCase
  def test_ruby_methods
    obj = [1, 2, 3]
    obj.freeze
    assert_raise RuntimeError do
      obj << 4
    end
  end
end