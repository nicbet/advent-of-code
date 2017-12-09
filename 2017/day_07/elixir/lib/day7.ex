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
    l_clean = l |> Enum.map(&String.trim/1)
    r_clean = r |> Enum.map(&String.trim/1)
    {l_clean, r_clean}
  end

  defp biset(%{"lhs" => lhs, "rhs" => "", "weight" => _}, {lh_nodes, rh_nodes}) do
    {lh_nodes ++ [lhs], rh_nodes}
  end
  defp biset(%{"lhs" => lhs, "rhs" => rhs, "weight" => weight}, {lh_nodes, rh_nodes}) do
    {lh_nodes ++ [lhs], rh_nodes ++ String.split(rhs, ~r/, /)}
  end

  @doc """
  Part 2 - Weights of subtrees
  """
  def make_tree(input) do
    input
    |> Enum.reduce(%{}, fn(%{"lhs" => node, "rhs" => children, "weight" => weight}, acc) -> Map.put(acc, node, %{:weight => str_to_i(weight), :children => String.split(children, ~r/, /, trim: true)}) end)
  end

  @doc """
  Calculate a nested list of all nodes with weights of all subtrees
  """
  def calc_weights(tree, node) do
    %{:weight => weight, :children => children} = Map.fetch!(tree, node)
    
    case children do
      []        -> [{node, weight }]
      children  -> [{node, weight}] ++ Enum.map(children, fn child -> calc_weights(tree, child) end)
    end
  end

  defp str_to_i(str) do
    str
    |> String.trim 
    |> String.to_integer
  end

  @doc """
  subtrees for a given node are balanced,
  if the sums over all weights in the subtree are equal,
  i.e., the list of the sums of all subtrees has only
  elements that are all the same. If that's not the case,
  Enum.uniq will leave us with a list with more than one element.
  """
  def subtrees_balanced?(node, tree) do
    %{:children => children} = Map.get(tree, node)
    count_uniq_sums = 
      children 
      |> Enum.map(fn n -> calc_weights(tree, n) |> sum_node_weights end) 
      |> Enum.uniq 
      |> Enum.count
    count_uniq_sums == 1 
  end

  @doc """
  Collapse a given nested list of subtrees with weighted nodes to a single number:
  the sum of all weights over all subtrees.
  """
  def sum_node_weights({node, weight}) do
    weight
  end
  def sum_node_weights(list_of_nodes) do
    list_of_nodes
    |> List.flatten
    |> Enum.reduce(0, fn ({_, weight}, acc) -> weight + acc end)
  end

  def find_broken_node(tree, node) do
    %{:children => children} = Map.get(tree, node)
    children |> Enum.reject( fn x -> subtrees_balanced?(x, tree) end)
  end

  def subtree_weight(node, tree) do
    calc_weights(tree, node) |> sum_node_weights
  end
  
end
