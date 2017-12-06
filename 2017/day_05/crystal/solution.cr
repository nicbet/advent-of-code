# Read the puzzle input from given file
def read_input(filename)
  # initialize a new array of Int32
  array = [] of Int32
  
  # Read the file line by line
  File.each_line(filename) do |line|
    # convert each line into Int32 and add to the array
    array << line.to_i32
  end
  
  # Print some info text...
  puts "Read #{array.size} lines"

  # ...and return the array
  return array
end

# Solution for Part 1
def process_part1(array)
  # Initialize
  current_pos = 0
  counter = 0

  # Check if we jumped outside the instructions list
  while current_pos < array.size
    # Let's see what the current value is
    current_value = array[current_pos]
  
    # Calculate where to jump next
    next_pos = current_pos + current_value
  
    # Increase the current value by 1
    array[current_pos] = current_value + 1

    # Move to next_pos
    current_pos = next_pos

    # Increase the counter
    counter += 1
  end

  # Done looping
  return counter
end

# Solution for Part 2
def process_part2(array)
  # Initialize
  current_pos = 0
  counter = 0
  n = array.size

  # Check if we jumped outside the instructions list
  while current_pos < n
    # Let's see what the current value is
    current_value = array[current_pos]
  
    # Calculate where to jump next
    next_pos = current_pos + current_value
  
    # Increase the current value by 1 if offset < 3; decrease otherwise
    if current_value < 3
      array[current_pos] = current_value + 1
    else
      array[current_pos] = current_value - 1
    end

    # Move to next_pos
    current_pos = next_pos

    # Increase the counter
    counter += 1
  end

  # Done looping
  return counter
end

# MAIN PROGRAM
puts "PART 1\n---------------\n"
instructions = read_input("../ex/input.txt")
count_1 = process_part1(instructions)
puts "We required #{count_1} steps for part 1.\n\n"

puts "PART 2\n---------------\n"
instructions = read_input("../ex/input.txt")
count_2 = process_part2(instructions)
puts "We required #{count_2} steps for part 2.\n\n"