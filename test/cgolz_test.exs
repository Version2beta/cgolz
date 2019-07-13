defmodule CgolzTest do
  use ExUnit.Case

  @beacon [{0, 0}, {0, 1}, {1, 0}, {1, 1}, {2, 2}, {2, 3}, {3, 2}, {3, 3}]

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
end
