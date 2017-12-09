defmodule Day6 do
  @moduledoc """
  Solutions for Day 6 Puzzle
  """ 
  def read_input(source) do
    File.read!(source)
    |> String.split(~r{\t})
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index
  end

  @doc """
  Solution for Part 1
  """
  def balance_part1(registers, count, seen) do
    if MapSet.member?(seen, registers) do
      count-1
    else
      n = Enum.count(registers)
      {blocks, register} = Enum.max_by(registers, &max_register/1)
      # IO.puts "Step #{count}, will balance register \##{register} containing #{blocks} blocks"
      # IO.inspect registers
      new_registers = registers |> List.replace_at(register, {0, register})
      next_pos = rem((register+1), n)
      
      new_registers
      |> redistribute(blocks, next_pos)
      |> balance_part1(count+1, MapSet.put(seen, registers))
    end
  end

  @doc """
  Solution for Part 1
  """
  def balance_part2(registers, count, seen) do
  IO.puts "#{count}"
    if Map.has_key?(seen, registers) && Map.get(seen, registers) > 2 do
      count - Map.get(seen, registers)
    else
      n = Enum.count(registers)
      {blocks, register} = Enum.max_by(registers, &max_register/1)
      
      new_registers = registers |> List.replace_at(register, {0, register})
      next_pos = rem((register+1), n)
      new_seen = case Map.has_key?(seen, registers) do
        false -> Map.put(seen, registers, 1)
        true -> Map.put(seen, registers, count)
      end

      new_registers
      |> redistribute(blocks, next_pos)
      |> balance_part2(count+1, new_seen)
    end
  end

  def redistribute(registers, 0, _) do
    # IO.puts("\tDone redistributing")
    # IO.inspect registers
    # IO.puts("\n")
    registers
  end
  def redistribute(registers, blocks_to_distribute, pos) do
    n = Enum.count(registers)
    {value, _} = Enum.at(registers, pos)
    updated_registers = List.replace_at(registers, pos, {value + 1, pos})
    # IO.puts("\tAdding one block to register #{pos}; was #{value}, now #{value+1}; #{blocks_to_distribute-1} blocks left")
    next_pos = rem((pos+1), n)
    redistribute(updated_registers, blocks_to_distribute-1, next_pos)
  end

  defp max_register({blocks, register}) do
    blocks
  end
        
end

# Main Program
memory = Day6.read_input("../input.tsv")

IO.puts "PART 1"
steps_part1 = Day6.balance_part1(memory, 1, MapSet.new)
IO.puts "Loop detected after #{steps_part1} steps!\n\n"

IO.puts "PART 2"
steps_part2 = Day6.balance_part2(memory, 1, Map.new)
IO.puts "Cycle is #{steps_part2} steps!\n\n"