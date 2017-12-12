class HexGrid
  def cubic_coords_from_origin(directions_list)
    x = 0
    y = 0
    z = 0
    max = 0

    directions_list.each do |direction|
      if direction == "n"
        x = x + 1
        y = y - 1
      end
      if direction == "s"
        x = x - 1
        y = y + 1
      end
      if direction == "ne"
        y = y - 1
        z = z + 1
      end
      if direction == "sw"
        y = y + 1
        z = z - 1
      end
      if direction == "nw"
        x = x + 1
        z = z - 1
      end
      if direction == "se"
        x = x -1
        z = z + 1
      end
      # Part 2
      dist = dist_from_origin(x,y,z)
      if dist > max
        max = dist
      end
    end
    [dist_from_origin(x,y,z),max]
  end

  def dist_from_origin(x, y, z)
    [x,y,z].map{|x| x.abs}.max
  end
end

hg = HexGrid.new

# Examples
puts hg.cubic_coords_from_origin(["ne", "ne", "ne"]).join(", ")
puts hg.cubic_coords_from_origin(["ne","ne","sw","sw"]).join(", ")
puts hg.cubic_coords_from_origin(["ne","ne","s","s"]).join(", ")
puts hg.cubic_coords_from_origin(["se","sw","se","sw","sw"]).join(", ")
puts hg.cubic_coords_from_origin(["ne","se","ne","se"]).join(", ")

puts "\n--------\n"

# Part 1 and 2 
data = IO.readlines("input.txt")
input = data[0].strip().split(",")
puts hg.cubic_coords_from_origin(input).join(", ")
