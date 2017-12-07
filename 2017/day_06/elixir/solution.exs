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

  def balance(registers, count, seen) do
    if MapSet.member?(seen, registers) do
      count-1
    else
      n = Enum.count(registers)
      {blocks, register} = Enum.max(registers)
      
      IO.puts "Step #{count}, will balance register \##{register} containing #{blocks} blocks"
      IO.inspect registers
      
      new_registers = registers |> List.replace_at(register, {0, register})
      next_pos = rem((register+1), n)
      
      redistribute(new_registers, blocks, next_pos)
      |> balance(count+1, MapSet.put(seen, registers))
    end
  end

  def redistribute(registers, 0, _) do
    IO.puts("\tDone redistributing")
    IO.inspect registers
    IO.puts("\n")
    registers
  end
  def redistribute(registers, blocks_to_distribute, pos) do
    n = Enum.count(registers)
    {value, _} = Enum.at(registers, pos)
    updated_registers = List.replace_at(registers, pos, {value + 1, pos})
    IO.puts("\tAdding one block to register #{pos}; was #{value}, now #{value+1}; #{blocks_to_distribute-1} blocks left")
    next_pos = rem((pos+1), n)
    redistribute(updated_registers, blocks_to_distribute-1, next_pos)
  end
        
end

# Main Program
memory = Day6.read_input("../input.tsv")
Day6.balance(memory, 0, MapSet.new)