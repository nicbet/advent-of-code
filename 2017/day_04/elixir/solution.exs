@moduledoc """
Solutions for Advent of Code 2017 - Day 04
  High-Entropy Passphrases
  https://adventofcode.com/2017/day/4
"""
defmodule Day4 do
  @doc """
  Solution for part 1 of the puzzle.

  The idea is to stream the contents of
  the given input file line by line,
  and from this stream of lines filter
  those lines out that contain duplicate words.

  We use the helper function unique_words?/1 in
  the filter.
  """
  def valid_phrases_part_1(source) do
    File.open!(source)
    |> IO.stream(:line)
    |> Enum.filter(&unique_words?/1)
    |> Enum.count
  end

  @doc """
  Determines whether all the words in given sentence are unique.
  """
  defp unique_words?(sentence) do
    words = String.split(sentence)
    uniq_words = Enum.uniq(words)
    
    Enum.count(words) == Enum.count(uniq_words)
  end

  @doc """
  Solution for part 2 of the puzzle.

  The idea is to stream the contents of
  the given input file line-by-line,
  and filter out all the lines that contain
  words which are an anagram of another word
  in the line.

  We use the helper function is_anagram_free?/1
  in the filter.
  """
  def valid_phrases_part_2(source) do
    File.open!(source)
    |> IO.stream(:line)
    |> Enum.filter(&is_anagram_free?/1)
    |> Enum.count
  end

  @doc """
  Determines whether a given sentence contains any words where a word is 
  an anagram of any other word in this sentence.
  """
  defp is_anagram_free?(sentence) do
    # Split the sentence into words and count.
    n = length(String.split(sentence))

    # Split the sentence into words, and convert words into their
    # canonical form (sorted by graphemes). Then obtain the unique
    # set of canonical words and count.
    n_a = 
      String.split(sentence)
      |> Enum.map(fn word -> String.graphemes(word) |> Enum.sort end)
      |> Enum.uniq
      |> Enum.count

    # If there were any anagrams then the length is not the same
    n == n_a
  end
end

IO.puts "Part 1"
IO.puts Day4.valid_phrases_part_1("passphrases.txt")

IO.puts "Part 2"
IO.puts Day4.valid_phrases_part_2("passphrases.txt")
