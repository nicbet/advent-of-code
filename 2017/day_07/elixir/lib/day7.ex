defmodule Day7 do
  @moduledoc """
  Documentation for Day7.
  """

  @doc """
  Read the puzzle input.
  Returns a list of maps of the form %{"lhs" => lhs, "rhs" => rhs, "weight" => weight}
  One such map per line in input file
  """
  def read_input(source) do
    source
    |> File.stream!
    |> Enum.map(fn line -> ~r/(?<lhs>.*) \((?<weight>\d+)\)( -> (?<rhs>.*))?/ |> Regex.named_captures(line) end)
  end

  @doc """
  Part 1 - Find the root of the tree
  """
  def find_root(input) do
    {l, r} = node_biset(input)
    l--r
  end

  defp node_biset(input) do
    {l, r} = input |> Enum.reduce({[],[]}, &biset/2)
    {l |> Enum.map(&String.trim/1), r |> Enum.map(&String.trim/1)}
  end

  defp biset(%{"lhs" => lhs, "rhs" => "", "weight" => _}, {lh_nodes, rh_nodes}) do
    {lh_nodes ++ [lhs], rh_nodes}
  end
  defp biset(%{"lhs" => lhs, "rhs" => rhs, "weight" => weight}, {lh_nodes, rh_nodes}) do
    {lh_nodes ++ [lhs], rh_nodes ++ String.split(rhs, ~r/,/)}
  end

  @doc """
  Part 2 - Weights of subtrees
  """
  def make_tree(input) do
    input
    |> Enum.reduce(%{}, fn (%{"lhs" => node, "rhs" => children, "weight" => weight}, acc) -> Map.put(acc, node, %{:weight => weight, :children => String.split(children, ~r/,/, trim: true)}) end)
  end

  def calc_weights(tree, root) do
    %{:weight => root_weight, :children => root_children} = Map.fetch!(tree, root)
    root_children
  end
  



end
