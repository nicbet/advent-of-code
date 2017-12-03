require "csv"

table = CSV.read("input.csv", col_sep: "\t", converters: [CSV::Converters[:integer]])

# Part 1
sum = 0
table.each do |row|
  row.sort!
  max = row.last.to_i
  min = row.first.to_i
  row_dif = max - min
  sum += row_dif
end

puts "The checksum for part 1 is #{sum}"

# Part 2
sum = 0
table.each do |row|
  row.sort!

end
