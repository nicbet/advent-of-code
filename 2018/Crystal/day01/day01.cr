# Read input
lines = File.read_lines("input.txt")

# Part 1
# Initialize running sum
run_sum = 0
# Cycle through the lines
lines.each do |line|
  # Calculate the current running sum
  run_sum += line.to_i
end
pp run_sum

# Part 2
# Initialize running sum and Hash Set of seen sums
run_sum = 0
run_sums = Set(Int32).new(lines.size)

# Cycle through the lines
lines.cycle do |line|
  # Calculate the current running sum
  run_sum += line.to_i
  # Check whether we have seen this sum before
  # if yes, print the value and done
  if run_sums.includes?(run_sum)
    pp run_sum
    exit 0
  else
    # otherwise add it to the set of seen sums
    run_sums.add(run_sum)
  end
end
