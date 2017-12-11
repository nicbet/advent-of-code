defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  test "trivial group {} is 1" do
    assert Day9.score("{}") == {1, 0}
  end

  test "groups {{{}}} is 6" do
    assert Day9.score("{{{}}}") == {6, 0}
  end

  test "groups {{},{}} is 5" do
    assert Day9.score("{{},{}}") == {5, 0}
  end

  test "groups {{{},{},{{}}}} is 16" do
    assert Day9.score("{{{},{},{{}}}}") == {16, 0}
  end

  test "group with garbage {<a>,<a>,<a>,<a>} is 1" do
    assert Day9.score("{<a>,<a>,<a>,<a>}") == {1, 4}
  end

  test "group with garbage {{<ab>},{<ab>},{<ab>},{<ab>}} is 9" do
    assert Day9.score("{{<ab>},{<ab>},{<ab>},{<ab>}}") == {9, 8}
  end

  test "group with garbage {{<!!>},{<!!>},{<!!>},{<!!>}} is 9" do
    assert Day9.score("{{<!!>},{<!!>},{<!!>},{<!!>}}") == {9, 0}
  end

  test "group with garbage {{<a!>},{<a!>},{<a!>},{<ab>}} is 3" do
    assert Day9.score("{{<a!>},{<a!>},{<a!>},{<ab>}}") == {3, 17}
  end

end
