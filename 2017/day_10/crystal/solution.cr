class KnotHash
  property data
  @list_len = 5

  def initialize
    @data = [] of Int32
    (0..@list_len-1).each do |i|
      @data << i
    end  
  end

  def knot(lengths)
    pos = 0
    skip = 0
    
    lengths.each do |l|
      rotate(pos, l)
      pos = l+skip
      skip = skip+1
    end
  end

  def rotate(pos, l)
    temp = @data.clone
    (pos+l..pos).each do |i|
      idx = i % @list_len
      puts "#{i} turns into array index #{idx}"
    end
  end

end

kh = KnotHash.new
puts "#{kh.data}"

lengths = [3, 4, 1, 5]
kh.knot(lengths)