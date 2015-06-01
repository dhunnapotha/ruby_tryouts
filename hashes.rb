# compare_by_identity
# flatten
# invert
# key(<value>)
# merge
# shfit

# freeze shit! what is that!

require 'debugger'
require 'test/unit'
class HashhTest < Test::Unit::TestCase
  def test_hash_basic_use_cases
    expected_hash = {1 => "a", 2 => "b"}
    assert_equal expected_hash, Hash[1, "a", 2, "b"]
    assert_equal expected_hash, Hash[[[1, "a"], [2, "b"]]]
    assert_equal expected_hash, Hash[1 => "a", 2 => "b"]


    # obj   = "key"
    # hash  = {}
    # hash[obj] = "value"
    # assert_equal "value", hash["key"]
    # hash.compare_by_identity
    # assert hash.compare_by_identity?
    # assert_nil hash["key"]
    # debugger
    # assert_equal "value", hash[obj]


    h = {}
    assert_nil h['a']
    h.default_proc = Proc.new{|hash, key| hash[key] = key + key}
    assert_equal 'aa', h['a']


    h = {1 => 2, 3 => [4, 5], 6 => [[7, 8], 9]}
    assert_equal [1, 2, 3, [4, 5], 6, [[7, 8], 9]], h.flatten
    assert_equal [1, 2, 3, 4, 5, 6, [7, 8], 9], h.flatten(2)
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], h.flatten(3)

  end


end