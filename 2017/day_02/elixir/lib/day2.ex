defmodule Day2 do
  def factor_pairs(list) do
    list
    |> Enum.flat_map( fn x -> list |> Enum.map( fn y -> {x,y} end ) end )
    |> Enum.uniq
    |> Enum.filter( fn {a,b} -> a != b && rem(a,b) == 0 end )
  end

  def row_sum_part2(row) do
    row
    |> factor_pairs
    |> Enum.map( fn {a,b} -> div(a,b) end)
    |> Enum.reduce(0, fn(x,acc) -> x + acc end)
  end

  def solution_part_2(table) do
    table
    |> Enum.map(&row_sum_part2/1)
  end
end
