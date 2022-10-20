defmodule Learn do
  def main do
    intersection("2,4,6","1,3,5")
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

  def union(intervals_1, intervals_2) do
    intervals_1 = expand(intervals_1)
    intervals_2 = expand(intervals_2)
    intervals = intervals_1 ++ intervals_2
    intervals = Enum.sort(intervals)
    intervals = Enum.uniq(intervals)
    collapse(intervals)
  end

  def intersection(intervals_1, intervals_2) do
    intervals_1 = expand(intervals_1)
    intervals_2 = expand(intervals_2)
    m1 = MapSet.new(intervals_1)
    m2 = MapSet.new(intervals_2)
    m3 = MapSet.intersection(m1, m2)
    collapse(MapSet.to_list(m3))
  end

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
