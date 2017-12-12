class Graph
    attr_accessor :nodes

    def initialize
        @nodes = []
        @g = {}
    end

    def add_edge(start_vertex, end_vertex, weight = 1, undirected = true)
        # Add reciprocal edges to graph map with weight
        if @g.has_key?(start_vertex)
            @g[start_vertex][end_vertex] = weight
        else
            @g[start_vertex] = {end_vertex => weight}
        end
        # Undirected graph
        if @g.has_key?(end_vertex)
            @g[end_vertex][start_vertex] = weight
        else
            @g[end_vertex] = {start_vertex => weight}
        end

        # Add to nodes list
        @nodes << start_vertex unless @nodes.include?(start_vertex)
        # Undirected graph
        @nodes << end_vertex unless @nodes.include?(end_vertex)
    end

    def to_s
        str = []
        @nodes.each do |n|
            str << "node #{n} with neigbors " + @g[n].keys.join(", ")
        end
        str.join("\n")            
    end

    def read_from_file(source_file)
        # Read source file and strip line endings
        lines = []
        lines = IO.readlines(source_file)
        lines.map! {|line| line.strip}
        # For each line split the input
        lines.each do |line|
            lhs, rhs = line.split(" <-> ")
            neighbors = rhs.split(", ")
            neighbors.each do |node|
                add_edge(lhs, node)
            end
        end
    end

    def [](k)
        @g[k]
    end
end

class DFS
    attr_accessor :visited

    def initialize(graph, source_node)
        @graph = graph
        @source_node = source_node
        @visited = []
        @edge_to = {}

        dfs(source_node)
    end

    def dfs(node)
        @visited << node
        @graph[node].keys.each do |adj_node|
            next if @visited.include?(adj_node)
            dfs(adj_node)
            @edge_to[adj_node] = node
        end
    end

    def has_path_to?(target_node)
        @visited.include?(target_node)
    end

    def reachable_nodes
        @visited.uniq
    end
end

# Sample
g1 = Graph.new
g1.read_from_file("../sample.txt")
puts g1
dfs1 = DFS.new(g1, "0")

puts "Number of programs in group: #{dfs1.reachable_nodes.size}"
puts dfs1.reachable_nodes.join(", ")

# Part 1
g2 = Graph.new
g2.read_from_file("../input.txt")
puts g2
dfs2 = DFS.new(g2, "0")

puts "Number of programs in group: #{dfs2.reachable_nodes.size}"
puts dfs2.reachable_nodes.join(", ")

# Part 2
nodes = g2.nodes
components = 0
while nodes.size > 0
    source = nodes[0]
    dfs = DFS.new(g2, source)
    nodes = nodes - dfs.reachable_nodes
    components = components + 1
    puts "Component #{components}"
    puts dfs.reachable_nodes.join(", ")
end

puts "Total of #{components} components in Graph"
