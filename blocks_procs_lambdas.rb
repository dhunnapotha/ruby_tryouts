# Reference: http://code.tutsplus.com/tutorials/ruby-on-rails-study-guide-blocks-procs-and-lambdas--net-29811

# -> Blocks are single use. Blocks are executed by calling yield inside methods. Blocks are supposed to be passed with '&' prepended to them
# -> Procs exist as objects. The behavior of procs and blocks are exactly equal. The only advantage is procs are re-usable block objects.  when a Proc encounters a return statement in it's execution, it halts the method and returns the provided value. Procs are executed by calling call function on the proc objects
# -> Lambdas have strict argument checking. Lambdas on the other hand, return their value to the method, allowing it to continue. Lamdas can also be represented by -> 


# GOTCHAs with return:
# You cannot have return outside a method or a block or a lambda. Create a ruby file and have return in it. It will throw LocalJumpError - Unexpected return
# Within a block - it causes the method that lexically encloses the block to return. It returns from the lexically enclosing method even in case of chained calls

class Array
  def gc_square_block(&block)
    output = []
    self.each_with_index do |item, index|
      output << yield(item)
    end
    output
  end

  def gc_square_proc(proc)
    output = []
    self.each_with_index do |item, index|
      output << proc.call(item)
    end
    output
  end

  def gc_lamda_proc(lamb)
    output = []
    self.each_with_index do |item, index|
      output << lamb.call(item)
    end
    output
  end


  def gc_proc_return(proc)
    proc.call
    return 2 
  end


  def gc_lamda_return(lamb)
    lamb.call
    return 2
  end
end


require 'test/unit'
class ArrayTest < Test::Unit::TestCase
  def test_square_block
    arr = [1, 2, 3]
    assert_equal [1, 4, 9], arr.gc_square_block{|x| x * x}
  end

  def test_square_proc
    p = Proc.new{|x| x * x}
    arr = [1, 2, 3]
    assert_equal [1, 4, 9], arr.gc_square_proc(p)
  end

  def test_square_lamda
    l = lambda {|x| x * x}
    arr = [1, 2, 3]
    assert_equal [1, 4, 9], arr.gc_lamda_proc(l)
  end

  def test_lamdba_for_arguments
    l = lambda {|x| x * x}
    assert_raise ArgumentError do
      l.call
    end
  end

  def test_return_values_of_procs_and_lamdbas
    p = Proc.new{return 1}
    l = -> {return 1}

    arr = []
    assert_equal 2, arr.gc_lamda_return(l)
  end

end
