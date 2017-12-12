class KnotHash
  @data = []
  @len = 0

  def initialize(len)
    @data = Range.new(0, len).to_a
    @len = len
  end

  def knot(inputs)
    pos  = 0
    skip = 0

    inputs.each do |input|
      rotate(input, pos)
      pos  = (pos + input + skip) % @len
      skip = skip + 1 
    end
  end

  def rotate(n_elements, starting_at)
    temp = []
    end_idx = starting_at + n_elements -1
    
    # Obtain sublist (cyclic over @data)
    (starting_at..end_idx).to_a.each do |idx|
      pos = idx % @len
      temp << @data[pos]
    end
    
    # Reverse the sublist
    r = temp.reverse
    
    # Modify @data cylic with values from the reversed sublist
    (starting_at..end_idx).to_a.each do |idx|
      pos = idx % @len
      @data[pos] = r[idx-starting_at]
    end
  end

  def checksum
    cs = @data[0] * @data[1]
    puts "Checksum: #{cs}"
  end

  def knotn(input, rounds)
    temp = []
    for i in 1..rounds
      temp = temp + input
    end
    knot(temp)
  end

  def dense_hash
    tmp = []
    for i in 0..15
      sub = @data[16*i, 16]
      d = sub.reduce(0, :^)
      tmp << d
    end
    tmp.map{|x| "%02x" %x}.join
  end

  def data
    @data
  end

end

# Sample
sample = [3, 4, 1, 5]
kh_sample = KnotHash.new(5)
kh_sample.knot(sample)
kh_sample.checksum

# Part 1
input = [120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113]
kh = KnotHash.new(256)
kh.knot(input)
kh.checksum

# Part 2
pad = [17, 31, 73, 47, 23]
str = "120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113"
bs = str.bytes
p2 = bs + pad
kh2 = KnotHash.new(256)
kh2.knotn(p2, 64)
puts "Hash: #{kh2.dense_hash}"