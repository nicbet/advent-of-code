defmodule Day4 do

  def valid_phrases_part_1(source) do
    File.open!(source)
    |> IO.stream(:line)
    |> Enum.filter(&unique_words?/1)
    |> Enum.count
  end

  defp unique_words?(input_string) do
    words = String.split(input_string)
    uniq_words = Enum.uniq(words)
    Enum.count(words) == Enum.count(uniq_words)
  end

  def valid_phrases_part_2(source) do
    File.open!(source)
    |> IO.stream(:line)
    |> Enum.filter(&is_anagram_free?/1)
    |> Enum.count
  end

  def is_anagram_free?(sentence) do
    n =
      String.split(sentence)
      |> Enum.count

    n_a =
      String.split(sentence)
      |> Enum.map(fn word -> String.graphemes(word) |> Enum.sort end)
      |> Enum.uniq
     |> Enum.count

    n == n_a
  end

  def contains_anagrams_for?(word, sentence) do
    String.split(sentence)
    |> Enum.filter(&is_anagram?(&1,word))
    |> Enum.empty? |> Kernel.not
  end

  def is_anagram?(word1, word2) do
    left = String.graphemes(word1)
    right = String.graphemes(word2)
    Enum.empty?(left -- right)
  end

end

IO.puts "Part 1"
IO.puts Day4.valid_phrases_part_1("passphrases.txt")

IO.puts "Part 2"
IO.puts Day4.valid_phrases_part_2("passphrases.txt")
