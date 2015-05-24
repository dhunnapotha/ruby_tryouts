# Reference : http://web.stanford.edu/~ouster/cgi-bin/cs142-winter15/classEval.php
# Run the test cases individually as one test case might effect the other. I tried to clear the definitions in the setup, but dint work out. Let me know if the function definitiosn can be cleared in setup / teardown 
# Running individual test case example: ruby class_and_instance_eval.rb -n test_zzz_class_eval_on_class_instance_behaves_like_instance_method

class MyClass
  def initialize num
    @num = num
  end
end

require 'test/unit'
class ClassAndInstanceEvalTest < Test::Unit::TestCase

  # as we dont have any getter or setter method or a function with that name
  def test_without_any_evals_should_raise_exceptions
    a = MyClass.new(1)
    b = MyClass.new(2)

    assert_raise NoMethodError do
      a.num
    end

    assert_raise NoMethodError do
      b.num
    end

  end


  #let us say we want to access num now. Define instance_val function in that case. It will act like a instance level function which has access to all private and protected methods. But it is defined only for that particualr instance
  def test_instance_eval_on_an_instance_should_effect_only_that_instance
    a = MyClass.new(1)
    b = MyClass.new(2)

    a.instance_eval do
      def num
        @num
      end
    end

    assert_equal 1, a.num
    assert_raise NoMethodError do
      b.num
    end
  end

  # Everything in ruby is an object. Classes are objects too. When you define MyClass, Ruby will create a global variable with  the name MyClass, which is the class object for MyClass. So, defining a instance_eval on class object 'MyClass' is like defining something like self.num

  def test_instance_eval_on_class_behaves_like_class_level_function
    a = MyClass.new(1)
    b = MyClass.new(2)

    MyClass.instance_eval do
      def num
        @num
      end
    end

    assert_raise NoMethodError do
      a.num
    end

    assert_nil MyClass.num
  end

  # class_eval can be called only on class objects and not on anyother kind of objects
  def test_class_eval_on_object_instances_raise_exception
    a = MyClass.new(1)
    assert_raise NoMethodError do
      a.class_eval do
      end
    end
  end

  def test_zzz_class_eval_on_class_instance_behaves_like_instance_method
    a = MyClass.new(1)

    MyClass.class_eval do
      def num
        @num
      end
    end

    assert_equal 1, a.num

    assert_raise NoMethodError do
      MyClass.num
    end
  end
end