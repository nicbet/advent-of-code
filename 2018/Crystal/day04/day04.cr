# Read input
lines = File.read_lines("input.txt").sort

# Init values
current_guard = 0
sleep_minute = 0
day = ""
table = Hash(Int32, Hash(Int32, Int32)).new

# Go through each entry and build up sleep time table
lines.each do |line|
  parts = line.split(/[\[\] :]/, remove_empty: true)

  d = parts[0]
  h = parts[1].to_i
  m = parts[2].to_i

  case parts[3]
  when "Guard"
    current_guard = parts[4].lstrip("#").to_i
    day = d
  when "falls"
    sleep_minute = m
  when "wakes"
    minutes = table.fetch(current_guard, Hash(Int32, Int32).new)
    (sleep_minute..(m - 1)).each do |minute|
      minutes[minute] = minutes.fetch(minute, 0) + 1
    end

    table[current_guard] = minutes
    sleep_minute = 0
  end
end

# Part 1
most_sleepy_guard = table.to_a.sort_by { |guard, minutes| minutes.values.sum }.last[0]
minute_most_slept_on = table[most_sleepy_guard].to_a.sort_by { |minute, times_asleep| times_asleep }.last[0]

pp most_sleepy_guard * minute_most_slept_on

# Part 2
max_minutes = Array(Tuple(Int32, Int32, Int32)).new
table.keys.each do |guard|
  mm = table[guard].to_a.sort_by { |minute, count| count }.last
  max_minutes << {guard, mm[0], mm[1]}
end
winner = max_minutes.sort_by { |e| e[2] }.last

pp winner[0] * winner[1]
