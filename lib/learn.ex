defmodule Learn do
  def main do
    collapse([1,2,4,5,6,8,9,12])
  end

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
    if items == [] do
      ""
    else
      chunk_fun = fn
        elem, [] -> {:cont, [elem]}
        elem, [prev | _] = acc when prev + 1 == elem -> {:cont, [elem | acc]}
        elem, acc -> {:cont, Enum.reverse(acc), [elem]}
      end
      after_fun = fn
       [] -> {:cont, []}
       acc -> {:cont, Enum.reverse(acc), []}
      end
      items = Enum.chunk_while(items, [], chunk_fun, after_fun)
      items = Enum.map(items, fn item ->
        if length(item) == 1 do
          "#{List.last(item)}"
        else
          "#{List.first(item)}-#{List.last(item)}"
        end
      end)
      items = Enum.join(items, ",")
      items
    end
  end

  # def union(intervals_1, intervals_2) do
  #   ""
  # end

  # def intersection(intervals_1, intervals_2) do
  #   ""
  # end

  # def difference(intervals_1, intervals_2) do
  #   ""
  # end

  # def is_disjoint(intervals_1, intervals_2) do
  #   true
  # end

  # def is_subset(intervals_1, intervals_2) do
  #   true
  # end

end
