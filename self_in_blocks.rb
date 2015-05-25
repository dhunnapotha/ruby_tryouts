# References http://nsomar.com/untiabout-ruby-selftled/
# Couldn't write test cases as self is being set at the test case class name :-/
class MyClass
  def run_block(block)
    block.call
  end

  def instance_eval_block(block)
    instance_eval(&block)
  end

  def self.class_instance_eval(block)
    instance_eval(&block)
  end


end

p = Proc.new{puts self}
myObj = MyClass.new

puts self #main
myObj.run_block(p) #main
myObj.instance_eval_block(p) ##<MyClass:0x00000006ab13e0> or something similar, which is the object instantiated
MyClass.class_eval(&p) #MyClass
MyClass.class_instance_eval(p) #MyClass
