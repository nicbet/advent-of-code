defmodule Day5 do
  @moduledoc """
  Solutions for Day 5
  """
  
  @doc """
  Read the input specific to the Day 5 puzzle format
  """
  def read_input_from_file(source_file) do
    source_file
    |> read_into_integer_list
    |> make_index_map
  end

  defp read_into_integer_list(source_file) do
    source_file
    |> File.stream!
    |> Enum.to_list
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  defp make_index_map(list) do
    0..length(list)-1
    |> Stream.zip(list)
    |> Enum.into(%{})
  end

  @doc """
  Solution for part 1
  """
  def move_over_input_part1(current_pos, counter, input) do
    current_val = Map.get(input, current_pos, :none)
    case current_val do
      :none -> {:done, counter}
      _ ->
        next_pos = current_pos + current_val
        counter = counter + 1
        new_input = Map.put(input, current_pos, current_val+1)
        move_over_input_part1(next_pos, counter, new_input)
    end
  end

  @doc """
  Solution for part 2
  """
  def move_over_input_part2(current_pos, counter, input) do
    current_val = Map.get(input, current_pos, :none)
    case current_val do
      :none -> {:done, counter}
      _ ->
        modifier = if current_val >= 3, do: -1, else: 1
        next_pos = current_pos + current_val
        counter = counter + 1
        new_input = Map.put(input, current_pos, current_val+modifier)
        move_over_input_part2(next_pos, counter, new_input)
    end
  end
end

# Main program
IO.puts("Reading instructions from input.txt...")
input = Day5.read_input_from_file("input.txt")

IO.puts("Calculating solution to part 1...")
IO.inspect Day5.move_over_input_part1(0, 0, input)

IO.puts("Calculating solution to part 2...")
IO.inspect Day5.move_over_input_part2(0, 0, input)
