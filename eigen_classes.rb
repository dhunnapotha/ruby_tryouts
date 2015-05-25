# Ref: http://madebydna.com/all/code/2011/06/24/eigenclasses-demystified.html
# The above link talks about eigenclasses / singleton classes / metaclasses and their impact in the method lookup

class Dog
end

# Common way that we use to define class functions
class Dog
  def self.bark_with_self
    "Batman Dog Bark"
  end
end

class << Dog
  def bark_with_operator
    "Deadpool Bark"
  end
end

class Dog
  class << self
    def bark_with_operator_inside_class_definition
      "Super Dog Barking"
    end
  end
end






require 'test/unit'
class EigenClassTest < Test::Unit::TestCase
  def test_instance_singleton_methods_using_def
    dog1 = Dog.new
    dog2 = Dog.new

    def dog1.bark
      "Bow!"
    end

    assert_equal "Bow!", dog1.bark
    assert_raise NoMethodError do
      dog2.bark
    end
  end

  def test_instance_singleton_methods_using_operator
    dog1 = Dog.new
    dog2 = Dog.new

    class << dog1
      def bark
        "Bow!"
      end
    end

    assert_equal "Bow!", dog1.bark
    assert_raise NoMethodError do
      dog2.bark
    end
  end

  def test_class_singleton_method_using_def
    def Dog.bark
      "Bow1!"
    end

    assert_equal "Bow1!", Dog.bark
  end

  def test_class_singleton_method_using_operator_inside_class_def
    assert_equal "Super Dog Barking", Dog.bark_with_operator_inside_class_definition
  end


  def test_class_singleton_method_using_def_self
    assert_equal "Batman Dog Bark", Dog.bark_with_self
  end


  def test_class_singleton_method_using_operator
    assert_equal "Deadpool Bark", Dog.bark_with_operator
  end


end