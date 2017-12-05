@moduledoc """
Solutions for Advent of Code - Day 5
https://adventofcode.com/2017/day/5
"""
defmodule Day5 do
    @doc """
    Read the input specific to the Day 5 puzzle format
    """
    def read_input_into_list(source_file) do
      source_file
      |> File.stream!
      |> Enum.to_list
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
    end

    @doc """
    Solution for part 1
    """
    def move_over_list_part1(current_pos, counter, list) do
      current_val = Enum.at(list, current_pos, :none)
      next_pos = current_pos + current_val
      counter = counter + 1

      if (next_pos >= length(list)) do
        {:done, counter}
      else
        new_list = List.replace_at(list, current_pos, current_val+1)
        move_over_list_part1(next_pos, counter, new_list)
      end
    end

    @doc """
    Naïve Solution for part 2
    TODO: Using a list here has horrible runtime - we can do better with a Map
    Something along the lines of
    1..length(list) |> Stream.zip(list) |> Enum.into(%{})
    and then use Map.put(...)
    """
    def move_over_list_part2(current_pos, counter, list) do
      current_val = Enum.at(list, current_pos, :none)
      next_pos = current_pos + current_val

      modifier = 1
      if current_val >= 3 do
        modifier = -1
      end

      counter = counter + 1

      if (next_pos >= length(list)) do
        {:done, counter}
      else
        new_list = List.replace_at(list, current_pos, current_val+modifier)
        move_over_list_part2(next_pos, counter, new_list)
      end
    end
end
