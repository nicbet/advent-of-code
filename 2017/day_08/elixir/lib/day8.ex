defmodule Day8 do
  @moduledoc """
  Solutions for Advent of Code - Day 8
  """
  def read_input(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Enum.map(&split_instructions/1)
  end

  defp split_instructions(str) do
    [ins, con] = String.split(str, " if ", trim: true)
    [var, op, amount] = String.split(ins, " ", trim: true)
    [cond_var, cond_op, cond_amount] = String.split(con, " ", trim: true)
    
    [
      var: var, 
      op: op,
      amount: String.to_integer(amount),
      cond_var: cond_var,
      cond_op: cond_op,
      cond_amount: String.to_integer(cond_amount)
    ]
  end

  def compute_part1_and_part2(instructions) do
    {registers, global_max} = 
      instructions
      |> Enum.reduce({Map.new, 0}, &execute_instruction/2)
    
    local_max = registers
    |> Map.values
    |> Enum.max

    {local_max, global_max}
  end
  
  defp execute_instruction([var: var, op: op, amount: amount, cond_var: cond_var, cond_op: cond_op, cond_amount: cond_amount], {registers, max}) do
    case cond_op do
      "<" ->
        if Map.get(registers, cond_var, 0) < cond_amount, do: run_op(registers, var, op, amount, max), else: {registers, max}
      ">" ->
        if Map.get(registers, cond_var, 0) > cond_amount, do: run_op(registers, var, op, amount, max), else: {registers, max}
      ">=" ->
        if Map.get(registers, cond_var, 0) >= cond_amount, do: run_op(registers, var, op, amount, max), else: {registers, max}
      "<=" ->
        if Map.get(registers, cond_var, 0) <= cond_amount, do: run_op(registers, var, op, amount, max), else: {registers, max}
      "!=" ->
        if Map.get(registers, cond_var, 0) != cond_amount, do: run_op(registers, var, op, amount, max), else: {registers, max}
      "==" ->
        if Map.get(registers, cond_var, 0) == cond_amount, do: run_op(registers, var, op, amount, max), else: {registers, max}
    end
  end
  
  defp run_op(registers, var, op, amount, max) do
    case op do
      "inc" ->
        new_val = Map.get(registers, var, 0) + amount
        new_registers = Map.put(registers, var, new_val)
        if new_val > max, do: {new_registers, new_val}, else: {new_registers, max}
      "dec" ->
        new_val = Map.get(registers, var, 0) - amount
        new_registers = Map.put(registers, var, new_val)
        if new_val > max, do: {new_registers, new_val}, else: {new_registers, max}
    end
  end
end
