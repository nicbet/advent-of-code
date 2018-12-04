defmodule Counter do
  defstruct elements: %{}

  def new() do
    %Counter{}
  end

  def add(%Counter{elements: elements}, items) when is_list(items) do
    elems =
      items
      |> Enum.reduce(elements, fn(x, acc) -> Map.update(acc, x, 1, &(&1+1)) end)
    %Counter{elements: elems}
  end
  def add(%Counter{elements: elements}, item) do
    # If elements has a key of item with a value, add 1,
    # otherwise add key and assign initial value of 1
    elems = Map.update(elements, item, 1, &(&1 + 1))
    %Counter{elements: elems}
  end

  def count(%Counter{elements: elements}, key) do
    case Map.fetch(elements, key) do
      {:ok, value} -> value
      _ -> 0
    end
  end

  def all(%Counter{elements: elements}), do: elements
end

defmodule Day03 do

	def intersect(a, b) do
		{_aid, ax1, ay1, ax2, ay2} = a
		{_bid, bx1, by1, bx2, by2} = b

		a_xmax = max(ax1, ax2)
		a_xmin = min(ax1, ax2)
		
		a_ymax = max(ay1, ay2)
		a_ymin = min(ay1, ay2)

		b_xmax = max(bx1, bx2)
		b_xmin = min(bx1, bx2)

		b_ymax = max(by1, by2)
		b_ymin = min(by1, by2)

		ox1 = min(a_xmax, b_xmax) 
		ox2 = max(a_xmin, b_xmin)
		
		oy1 = min(a_ymax, b_ymax)
		oy2 = max(a_ymin, b_ymin)
		
		{ox1, oy1, ox2, oy2}
	end


	def parse_input_line(line) do
		[[_l, id, x, y, w, h]] = Regex.scan(~r/(#.+) @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)/, line)
		# return rect
		{
			id,
			String.to_integer(x), 
			String.to_integer(y), 
			String.to_integer(x) + String.to_integer(w) -1, 
			String.to_integer(y) + String.to_integer(h) -1
		} 
	end
	
end

ExUnit.start(timeout: 100000000)

defmodule Day03Test do
	use ExUnit.Case
	import Day03
	import Counter

	test "parse input line" do
		assert parse_input_line("#1 @ 1,3: 4x4") == {"#1", 1, 3, 4, 6}
	end

	test "part 1 example" do
		input = 
		["#1 @ 1,3: 4x4",
		"#2 @ 3,1: 4x4",
		"#3 @ 5,5: 2x2"]
		
		
		n = input 
		|> Enum.map(&parse_input_line/1) 
		|> Enum.reduce(Counter.new(), fn ({_id, x1, y1, x2, y2}, counter) -> 
			 		coords = for i <- x1..x2, j <- y1..y2, do: {i,j}
					coords
					|> Enum.reduce(counter, fn({a,b}, acc) -> Counter.add(acc, {a,b}) end)
			 end)
		|> Counter.all()
		|> Map.values()
		|> Enum.filter(fn x -> x > 1 end)
		|> Enum.count()

		assert n == 4
	end

	test "part 1" do
		input = File.stream!("day03_input.txt")
		
		
		n = input 
		|> Enum.map(&parse_input_line/1) 
		|> Enum.reduce(Counter.new(), fn ({_id, x1, y1, x2, y2}, counter) -> 
			 		coords = for i <- x1..x2, j <- y1..y2, do: {i,j}
					coords
					|> Enum.reduce(counter, fn({a,b}, acc) -> Counter.add(acc, {a,b}) end)
			 end)
		|> Counter.all()
		|> Map.values()
		|> Enum.filter(fn x -> x > 1 end)
		|> Enum.count()

		assert n == 107043
	end

	test "part2" do
		input = File.stream!("day03_input.txt")
		
		
		hist = input 
		|> Enum.map(&parse_input_line/1) 
		|> Enum.reduce(Counter.new(), fn ({_id, x1, y1, x2, y2}, counter) -> 
			 		coords = for i <- x1..x2, j <- y1..y2, do: {i,j}
					coords
					|> Enum.reduce(counter, fn({a,b}, acc) -> Counter.add(acc, {a,b}) end)
			 end)

		{id, x1, y1, x2, y2} = 
			input 
			|> Enum.map(&parse_input_line/1) 
			|> Enum.reject(
				fn {id, x1, y1, x2, y2} ->  
					coords = for i <- x1..x2, j <- y1..y2, do: {i,j}
					coords |> Enum.any?(fn {x,y} -> Counter.count(hist, {x,y}) > 1 end)
				end)
			|> List.first()

			assert id == "#346"

	end
end