require 'test/unit'

class ArrayTest < Test::Unit::TestCase
  def test_array_basics
    assert_equal [true, true], Array.new(2, true)

    # multiple instances of the same object
    arr = Array.new(2, {:a => "b"})
    assert_equal [{:a => "b"}, {:a => "b"}], arr
    arr[0][:a] = "c"
    assert_equal [{:a => "c"}, {:a => "c"}], arr


    arr = [1, 2, 3]
    assert_equal [1, 2], arr.take(2)
    assert_equal [3], arr.drop(2)

    arr1 = [1, 2]
    arr2 = [1, 3]
    assert_equal [1, 2, 3], arr1 | arr2
    assert_equal [[1, 1], [2, 3]], arr1.zip(arr2)


    arr = [1, 2, 2, 2]
    assert_equal 1, arr.index(2)
    assert_equal 3, arr.rindex(2)

    arr = [1, 2]
    assert_equal [[1, 1], [1, 2], [2, 2]], arr.repeated_combination(2).to_a
    assert_equal [[1, 1], [1, 2], [2, 1], [2, 2]], arr.repeated_permutation(2).to_a


    arr1 = [1, 2]
    arr2 = [3, 4]
    arr3 = [5, 6]
    assert_equal [[1, 3, 5], [1, 3, 6], [1, 4, 5], [1, 4, 6], [2, 3, 5], [2, 3, 6], [2, 4, 5], [2, 4, 6]], arr1.product(arr2, arr3)


    arr = [1, 2, 3, 4]
    assert_equal 4, arr.count
    assert_equal 2, arr.count{|x| x >= 3}


    # Flattens recursively
    arr = [1, [2, [3, 4]]]
    assert_equal [1, 2, 3, 4], arr.flatten

  end




end