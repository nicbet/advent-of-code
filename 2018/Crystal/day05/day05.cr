sample_input = "dabAcCaCBAcCcaDA"
input = File.read("input.txt")

def react(str)
  (0..str.size-2).each do |idx|
    l = str[idx]
    r = str[idx+1]
    if (l.ord - r.ord).abs == 32
      sb = String::Builder.new(str.size-2)
      str.chars.each_with_index do |char, i|
        sb << char unless (i == idx || i == (idx+1))
      end
      return react(sb.to_s)
    end
  end
  return str
end



left_over = react(sample_input)
pp left_over, left_over.size

#left_over = react(input)
#pp left_over.size

# Part 2
channel = Channel(Tuple(Char, Int32)).new
final_polymers = Array(Tuple(Char, Int32)).new
('a'..'z').each do |c|
  spawn {
    pp c
    new_input = input.gsub(/[#{c}#{c.upcase}]/,"")
    left_over = react(new_input)
    channel.send({c, left_over.size})
  }
  final_polymers << channel.receive
end

pp final_polymers