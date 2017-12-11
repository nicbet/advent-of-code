defmodule Day9 do
  @moduledoc """
  Solution for Advent of Code - Day 9
  """

  @doc """
  Main and only function, will calculate the score for part 1 and part 2
  at the same time. Returns a tuple {group_score, number_of_garbage_chars}
  """
  def score(input) do
    move(input, 0, 0, 0, false)
  end

  # Pattern matching works really well for todays solution
  defp move("", _, score, garbage_count, _) do
    {score, garbage_count}
  end
  defp move("{" <> tail, depth, score, garbage_count, garbage) do
    case garbage do 
      false -> move(tail, depth+1, score, garbage_count, false)
      true  -> move(tail, depth, score, garbage_count+1, true)
    end
  end
  defp move("}" <> tail, depth, score, garbage_count, garbage) do
    case garbage do
      false -> move(tail, depth-1, score+depth, garbage_count, false)
      true  -> move(tail, depth, score, garbage_count+1, true)
    end
  end
  defp move("<" <> tail, depth, score, garbage_count, garbage) do
    case garbage do
      false -> move(tail, depth, score, garbage_count, true)
      true  -> move(tail, depth, score, garbage_count+1, true)
    end
  end
  defp move(">" <> tail, depth, score, garbage_count, garbage) do
    case garbage do
      false -> move(tail, depth, score, garbage_count, false)
      true  -> move(tail, depth, score, garbage_count, false)
    end
  end
  defp move("!" <> <<_::size(8)>> <> tail, depth, score, garbage_count, garbage) do
    case garbage do
      false -> move(tail, depth, score, garbage_count, garbage)
      true  -> move(tail, depth, score, garbage_count, garbage)
    end
  end
  defp move(<<_::size(8)>> <> tail, depth, score, garbage_count, garbage) do
    case garbage do
      false -> move(tail, depth, score, garbage_count, garbage)
      true  -> move(tail,depth, score, garbage_count+1, garbage)
    end
  end
end
