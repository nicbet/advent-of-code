lines = File.read_lines("input.txt")

def parse_line(line)
  parts = line.split(/[# @,:x]/, remove_empty: true)
  id = parts[0]
  x = parts[1].to_i
  y = parts[2].to_i
  w = parts[3].to_i
  h = parts[4].to_i
  return {id, x, y, w, h}
end

# Part 1
coords = Hash(Tuple(Int32, Int32), Array(String)).new
lines.each do |line|
  id, x, y, w, h = parse_line(line)

  (x..(x + w - 1)).each do |i|
    (y..(y + h - 1)).each do |j|
      covered_by = coords.fetch({i, j}, [] of String) << id
      coords[{i, j}] = covered_by
    end
  end
end

pp coords.values.map { |ids| ids.size }.count { |e| e > 1 }

# Part 2
lines.each do |line|
  id, x, y, w, h = parse_line(line)

  unique = true
  (x..(x + w - 1)).each do |i|
    (y..(y + h - 1)).each do |j|
      ids_on_coord = coords.fetch({i, j}, [] of String)
      unique = unique & !(ids_on_coord.size > 1)
    end
  end
  if unique
    pp id
    exit 0
  end
end
