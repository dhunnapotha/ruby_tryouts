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


  # == === equal? eql?
  # eql is more or less alias to ==, but the classes can have their own behavior
  # === case equality
  def test_equality_operations
    obj1 = []
    obj2 = []

    assert obj1 == obj2
    assert obj1 === obj2
    assert obj1.eql?(obj2)
    assert_equal false, obj1.equal?(obj2)
  end
end