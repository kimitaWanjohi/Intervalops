defmodule IntervalOpsTest do
  use ExUnit.Case
  doctest IntervalOps

  test "expand_1", do: assert IntervalOps.expand("") == []
  test "expand_2", do: assert IntervalOps.expand("42") == [42]
  test "expand_3", do: assert IntervalOps.expand("4-5") == [4,5]
  test "expand_4", do: assert IntervalOps.expand("4-6,10-12,16") == [4,5,6,10,11,12,16]
  test "expand_5", do: assert IntervalOps.expand("1,3-5,12-14,9999") == [1,3,4,5,12,13,14,9999]
  
  test "collapse_1", do: assert IntervalOps.collapse([]) == ""
  test "collapse_2", do: assert IntervalOps.collapse([1,2,4,5,6,8,9,12]) == "1-2,4-6,8-9,12"
  test "collapse_3", do: assert IntervalOps.collapse([1,2,3,4,5,6,7,8,9]) == "1-9"
  test "collapse_4", do: assert IntervalOps.collapse([2,4,6,8,10]) == "2,4,6,8,10"
  
  test "union_1", do: assert IntervalOps.union("2,4,6","1,3,5") == "1-6"
  test "union_2", do: assert IntervalOps.union("1-3","4-6") == "1-6"
  test "union_3", do: assert IntervalOps.union("1-9","10") == "1-10"
  test "union_4", do: assert IntervalOps.union("4-6,10-12,16","1,3-5,12-14") == "1,3-6,10-14,16"

  test "intersection_1", do: assert IntervalOps.intersection("2,4,6","1,3,5") == ""
  test "intersection_2", do: assert IntervalOps.intersection("2,4,6","4-8") == "4,6"
  test "intersection_3", do: assert IntervalOps.intersection("4-6,10-12,16","1,3-5,12-14") == "4-5,12"

  test "difference_1", do: assert IntervalOps.difference("1-5,7-9","4-8") == "1-3,9"
  test "difference_2", do: assert IntervalOps.difference("4-8","1-5,7-9") == "6"
  test "difference_3", do: assert IntervalOps.difference("","10") == ""

  test "is_disjoint_1", do: assert IntervalOps.is_disjoint("4-7","1-3,8-9") == true
  test "is_disjoint_2", do: assert IntervalOps.is_disjoint("4-6,10-12,16","1,3-5,12-14") == false
  test "is_disjoint_3", do: assert IntervalOps.is_disjoint("","10") == true

  test "is_subset_1", do: assert IntervalOps.is_subset("1-5,7-9","1-9") == true
  test "is_subset_2", do: assert IntervalOps.is_subset("4-6,10-12,16","1,3-5,12-14") == false
  test "is_subset_3", do: assert IntervalOps.is_subset("","10") == true

end
