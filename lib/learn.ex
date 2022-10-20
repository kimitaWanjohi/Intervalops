defmodule Learn do
  def main do
    expand("1")
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
end


#Intervals: Expected result:
#“”                       (empty string) [] (empty list)
#“42”                     [42]
#“4-5”                    [4, 5]
#“4-6,10-12,16”           [4, 5, 6, 10, 11, 12, 16]
#“1,3-5,12-14,9999”       [1, 3, 4, 5, 12, 13, 14, 9999]
