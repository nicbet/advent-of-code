def read_input(source_file)
  firewall = {}
  lines = IO.readlines(source_file)
  lines = lines.map{|line| line.strip}
  lines.each do |line|
    layer, width = line.split(": ")
    firewall[layer.to_i] = width.to_i
  end
  firewall
end

def is_caught?(firewall, time_step, layer)
  # A security program will be in layer 0 (catching you)
  # every (2*width-2) time_steps
  width = firewall.has_key?(layer) ? firewall[layer] : 0
  if width > 0
    k = 2*width-2
    return true if time_step % k == 0
  end
  false
end

def find_layers_where_caught(firewall, time_offset = 0)
  n = firewall.keys.max
  caught = []
  
  (0..n).each do |k|
    caught << k if is_caught?(firewall, k+time_offset, k)
  end
  caught
end

def calculate_severity(caught_layers, firewall)
  severity = 0
  caught_layers.each do |layer|
    severity = severity + layer * firewall[layer]
  end
  severity
end

# Read the puzzle definition from the given file
firewall = read_input("../input.txt")

# PART 1 ---------------------------
# Find the layers where we get caught
caught = find_layers_where_caught(firewall, 0)

# Use that information to calculate the severity
severity = calculate_severity(caught, firewall)

# Solution to part 1
puts "Severity is #{severity}"

# PART 2 ---------------------------
def find_passing_offset(firewall)
  offset = 0
  n = firewall.keys.max
  while true
    pass = true
    (0..n).each do |i|
      if is_caught?(firewall, i+offset, i)
        pass = false
        break
      end
    end
    if !pass
      offset = offset + 1
    else
      return offset
    end
  end
  return -1
end

passing_time = find_passing_offset(firewall)
puts "Wait #{passing_time} picoseconds to pass undetected"