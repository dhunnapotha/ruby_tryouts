# freeze

require 'test/unit'

class DupCloneDiff
  def instance_method
    "instance method"
  end
end

class OtherRubyFunctionsTest < Test::Unit::TestCase
  def test_freeze
    obj = [1, 2, 3]
    obj.freeze
    assert_raise RuntimeError do
      obj << 4
    end
  end

  # diffs between dup and clone

  def test_dup_and_clone
    obj = DupCloneDiff.new

    def obj.singleton_method
      "singleton method"
    end

    dup_obj = obj.dup
    assert_equal "instance method", dup_obj.instance_method
    #singleton methods are not available in dup
    assert_raise NoMethodError do
      dup_obj.singleton_method
    end

    clone_obj = obj.clone
    assert_equal "instance method", clone_obj.instance_method
    #singleton methods are available in clone 
    assert_equal "singleton method", clone_obj.singleton_method

    obj.freeze

    assert_equal false, obj.dup.frozen?
    assert obj.clone.frozen?

  end


  # == is the normal equal to that we know of
  # eql? is == + class match
  # equal? is the exact object match
  def test_equality_operations

    num_int = 1
    num_float = 1.0

    assert_equal true, num_int == num_float
    assert_equal false, num_int.eql?(num_float)
    assert_equal false, num_int.equal?(num_float)
    assert_equal true, num_int.equal?(num_int)

  end

  # Ruby gotchas

  # a === b in general means, if a describes a set, would b a member of that set?

  def test_three_equal_signs
    num_int = 1
    num_float = 1.0


    assert_equal true, num_int === num_float
    assert_equal true, (1..3) === 2
    assert_equal false, 2 === (1..3)


    assert_equal true, Object === Class
    assert_equal true, Object === Object
    assert_equal true, Class  === Object
    assert_equal true, Class  === Class


    assert_equal false, String  === String
    assert_equal false, Fixnum  === Fixnum

  end


end