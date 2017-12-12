defmodule Day12 do

  def read_input(source_file) do
    File.stream!(source_file)
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(Graph.new(type: :undirected), &Day12.make_graph/2)
  end

  def make_graph(line, g = %Graph{}) do
    [source, neighbour_list] = String.split(line, ~r/ \<-\> /)
    neighbours = String.split(neighbour_list, ~r/, /)
    Enum.reduce(neighbours, g, fn (node, acc) -> Graph.add_edge(acc, source, node) end)
  end

end

# Sample
g1 = Day12.read_input("../sample.txt")
c01 = g1 |> Graph.components |> Enum.filter(fn x -> Enum.member?(x, "0") end) |> List.flatten
IO.puts "Component that includes \"0\" is"
IO.inspect c01
IO.puts "It has #{Enum.count(c01)} programs"
IO.puts "There are #{g1 |> Graph.components |> Enum.count} many components\n\n"

# Part 1 and Part 2
g2 = Day12.read_input("../input.txt")
c02 = g2 |> Graph.components |> Enum.filter(fn x -> Enum.member?(x, "0") end) |> List.flatten
IO.puts "Component that includes \"0\" is"
IO.inspect c02
IO.puts "It has #{Enum.count(c02)} programs"
IO.puts "There are #{g2 |> Graph.components |> Enum.count} many components\n\n"
