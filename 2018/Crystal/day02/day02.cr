lines = File.read_lines("input.txt")

# Part 1
counts = Hash(Int32, Int32).new

lines.each do |line|
  chars = line.chars
  freqs = Hash(Char, Int32).new
  chars.each do |char|
    n = freqs.fetch(char, 0)
    freqs[char] = n + 1
  end

  twos = freqs.has_value?(2) ? counts.fetch(2, 0) + 1 : counts.fetch(2, 0)
  threes = freqs.has_value?(3) ? counts.fetch(3, 0) + 1 : counts.fetch(3, 0)
  counts[2] = twos
  counts[3] = threes
end

pp counts[2], counts[3]
pp counts[2] * counts[3]

# Part 2
require "levenshtein"
lines.each do |line|
  lines.each do |other_line|
    distance = Levenshtein.distance(line, other_line)
    if distance == 1
      c = line.chars.map_with_index do |char, i|
        char unless char != other_line[i]
      end
      pp c.compact.join("")
      exit 0
    end
  end
end
