defmodule Ex do
  import ExProf.Macro

  def run do
    inp = read_input_from_file("input.txt")
    profile do
      move_over_input_part2(0, 0, inp)
    end
  end

  @doc """
  Read the input specific to the Day 5 puzzle format
  """
  def read_input_from_file(source_file) do
    list =
      source_file
      |> File.stream!
      |> Enum.to_list
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)

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
