class Node
  property name 
  property weight 
  property children

  def initialize(name : String, weight : Int32)
    @name = name
    @weight = weight
    @children = [] of Node
  end
end

class Tree 
  property root_node

  def initialize(root_name : String, root_weight : Int32)
    @root_node = Node.new(root_name, root_weight)
  end
end

# Read the puzzle input from given file
def read_input(filename)
  # initialize a new array of lines
  array = [] of String
  # Read the file line by line
  File.each_line(filename) do |line|
    array << line
  end
  # Print some info text...
  puts "Read #{array.size} lines of input"
  # ...and return the array
  return array
end

def make_tree(lines)
  lines.each do |line|
    parts = line.split(/->/)
  end
end


def find_root(input)

end

# Main Program
# lines = read_input("../input.txt")
#tree = make_tree(input)