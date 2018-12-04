defmodule Day02 do
	defp input do
		File.stream!("day02_input.txt")
		|> Enum.map(&String.trim/1)
	end

	def has_n?(input, n) do
		String.graphemes(input)
		|> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
		|> Enum.filter(fn {_, b} -> b == n end) |> Enum.count() > 0
	end

	def part1() do
		a = 
			input()
			|> Enum.filter(&has_n?(&1, 2))
			|> Enum.count()

		b = 
			input()
			|> Enum.filter(&has_n?(&1, 3))
			|> Enum.count()
		
		a * b
	end

	def part2() do
		[a,b] =
			input()
			|> Enum.map(fn elem -> 
				input() |> Enum.filter(fn inner -> 
					distance(elem, inner) == 1
				end)
			end)
			|> Enum.filter(fn x -> Enum.count(x) > 0 end)
			|> List.flatten()

		same_letters(a, b) |> Enum.join()
	end

	def distance(str1, str2) do
		Enum.zip(String.graphemes(str1), String.graphemes(str2))
		|> Enum.reject(fn {a,b} -> a == b end)
		|> Enum.count()
	end

	def same_letters(str1, str2) do
		Enum.zip(String.graphemes(str1), String.graphemes(str2))
		|> Enum.filter(fn {a,b} -> a == b end)
		|> Enum.map(fn {a, _} -> a end)
	end

	
end

ExUnit.start()

defmodule Day02Test do
	use ExUnit.Case
	import Day02

	test "part1" do
		assert part1() == 8820
	end

	test "distance" do
		assert distance("abcde", "axcye") == 2
	end

	test "part2" do
		assert part2() == "bpacnmglhizqygfsjixtkwudr"
	end
	
end