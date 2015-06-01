require 'test/unit'
class HashhTest < Test::Unit::TestCase
  def test_hash_basic_use_cases
    expected_hash = {1 => "a", 2 => "b"}
    assert_equal expected_hash, Hash[1, "a", 2, "b"]
    assert_equal expected_hash, Hash[[[1, "a"], [2, "b"]]]
    assert_equal expected_hash, Hash[1 => "a", 2 => "b"]


    h = {"a" => "b", :c => :d}
    assert_equal "b", h["a"]
    h.compare_by_identity
    assert h.compare_by_identity? 
    assert_nil h["a"]
    assert_equal :d, h[:c]



    h = {}
    assert_nil h['a']
    h.default_proc = Proc.new{|hash, key| hash[key] = key + key}
    assert_equal 'aa', h['a']


    h = {1 => 2, 3 => [4, 5], 6 => [[7, 8], 9]}
    assert_equal [1, 2, 3, [4, 5], 6, [[7, 8], 9]], h.flatten
    assert_equal [1, 2, 3, 4, 5, 6, [7, 8], 9], h.flatten(2)
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], h.flatten(3)

    h = {1 => 2, 3 => 4}
    expected_hash = {2 => 1, 4 => 3}
    assert_equal expected_hash, h.invert

    h = {1 => 2}
    assert_equal 1, h.key(2)


    h1 = {1 => 2}
    h2 = {1 => 3, 4 => 5}
    expected_hash = {1 => 3, 4 => 5}
    assert_equal expected_hash, h1.merge(h2)

    h = {1 => 2, 3 => 4}
    assert_equal [1, 2], h.shift


    a = "a"
    b = "b".freeze
    h = {a => 100, b => 200}
    assert_false h.key(100).equal? a
    assert h.key(200).equal? b
  end


end