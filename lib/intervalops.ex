defmodule IntervalOps do
  @moduledoc """
    Documentation for `IntervalOps`.
  """

  @doc """
    Function stubs for you to fill in are given below. Feel free to add as many
    additional helper functions as you want.

    The tests for these functions can be found in test/intervalops_test.exs.
    You are encouraged to add your own tests in addition to those provided.

    Run the tester by executing 'mix test' from the intervalops directory
    (the one containing mix.exs)
  """

  def expand(intervals) do
    if intervals == "" do
      []
    else
      list_intervals = String.split(intervals, ",")
      intervals_list = Enum.map(list_intervals, fn interval ->
        if String.contains?(interval, "-") do
          [first, last] = String.split(interval, "-")
          first = String.to_integer(first)
          last = String.to_integer(last)
          Enum.to_list(first..last)
        else
          [String.to_integer(interval)]
        end
      end)
      List.flatten(intervals_list)
    end
  end

  def collapse(items) do
    ""
  end

  def union(intervals_1, intervals_2) do
    ""
  end

  def intersection(intervals_1, intervals_2) do
    ""
  end

  def difference(intervals_1, intervals_2) do
    ""
  end

  def is_disjoint(intervals_1, intervals_2) do
    true
  end

  def is_subset(intervals_1, intervals_2) do
    true
  end

end
