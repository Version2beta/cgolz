defmodule CgolzTest do
  use ExUnit.Case

  @beacon [{0, 0}, {0, 1}, {1, 0}, {1, 1}, {2, 2}, {2, 3}, {3, 2}, {3, 3}]
  @beacon_2 [{0, 0}, {0, 1}, {1, 0}, {2, 3}, {3, 2}, {3, 3}]
  @blinker [{1, 0}, {1, 1}, {1, 2}]
  @blinker_2 [{0, 1}, {1, 1}, {2, 1}]
  @toad [{0, 1}, {1, 0}, {1, 1}, {2, 0}, {2, 1}, {3, 0}]
  @toad_2 [{0, 0}, {0, 1}, {1, 2}, {2, -1}, {3, 0}, {3, 1}]

  test "finds a brain in a camp",
    do: assert(Cgolz.check_site(@beacon, {1, 1}) == :brains)

  test "finds a zombie in a camp",
    do: assert(Cgolz.check_site(@beacon, {2, 1}) == :zombie)

  test "finds neighbors" do
    assert Cgolz.find_neighbors({0, 0}) == [
             {-1, -1},
             {0, -1},
             {1, -1},
             {-1, 0},
             {1, 0},
             {-1, 1},
             {0, 1},
             {1, 1}
           ]
  end

  test "counts neighbors when there are some",
    do: assert(Cgolz.count_neighbors(@beacon, {1, 2}) == {{1, 2}, 4})

  test "counts neighbors when there aren't any",
    do: assert(Cgolz.count_neighbors(@beacon, {-100, -100}) == {{-100, -100}, 0})

  test "takes known oscillators to through their future generations" do
    assert Cgolz.tick(@beacon) |> Enum.sort() == @beacon_2
    assert Cgolz.tick(@blinker) |> Enum.sort() == @blinker_2
    assert Cgolz.tick(@toad) |> Enum.sort() == @toad_2
    assert Cgolz.tick(@beacon_2) |> Enum.sort() == @beacon
    assert Cgolz.tick(@blinker_2) |> Enum.sort() == @blinker
    assert Cgolz.tick(@toad_2) |> Enum.sort() == @toad
  end
end
