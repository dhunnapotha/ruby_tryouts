# References:
# http://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/
# http://nsomar.com/untiabout-ruby-selftled/

# mechanism           | method resolution   | method definition | new scope?
# class Person        | Person              | same              | yes
# class << Person     | Person's metaclass  | same              | yes
# Person.class_eval   | Person              | same              | no
# Person.instance_eval| Person              | Person's metaclass|  no
############
# Basically, method resolution resolves to metaclass when << operator is being used to define metaclasses.
# Method definiition in case of instance_eval shouldn't really effect because anyways the resolution is on Person, which the user is more concerned about.

# Output when this file is executed should be
# self inside metaclass - 
# self inside class_eval - Person
# self inside instance_eval - Person


# In a nutshell - self.name will either give Person or Gautam - depending on whether it is a class level function or a object function, irrespective of how the methods are defined. 

# When called self.name inside metaclass code block, that are opened by <<  (not inside functions defined in metaclass code blocks), it will be empty because self is metaclass in such case. 

class Person
  def name
    "Gautam"
  end

  def self_inside_method
    self.name
  end

  def self.self_inside_class_method
    self.name
  end

  class << self
    def self_inside_metaclass_definition
      self.name
    end

    puts "self inside metaclass - #{self.name}"
  end
end


def Person.self_inside_class_method_defined_on_class
  self.name  
end


Person.class_eval do

  def self_inside_class_eval
    self.name
  end

  puts "self inside class_eval - #{self.name}" #Person

end

Person.instance_eval do
  def self_inside_instance_eval_definition
    self.name
  end

  puts "self inside instance_eval - #{self.name}" #Person
end


require 'test/unit'

class TestSelf < Test::Unit::TestCase
  def test_self_values

    assert_equal "Gautam", Person.new.name
    assert_equal "Person", Person.name
    assert_equal "Gautam", Person.new.self_inside_method
    assert_equal "Person", Person.self_inside_class_method

    assert_equal "Person", Person.self_inside_metaclass_definition
    assert_equal "Person", Person.self_inside_class_method_defined_on_class
    assert_equal "Gautam", Person.new.self_inside_class_eval
    assert_equal "Person", Person.self_inside_instance_eval_definition
  end
end

