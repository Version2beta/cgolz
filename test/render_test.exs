defmodule CgolzTest.Render do
  use ExUnit.Case
  alias Cgolz.Render

  @beacon [{0, 0}, {0, 1}, {1, 0}, {1, 1}, {2, 2}, {2, 3}, {3, 2}, {3, 3}]
  @offset :rand.uniform(100)
  @offset_beacon Enum.map(@beacon, fn {x, y} -> {x - @offset, y - @offset} end)

  test "rangefinder finds range" do
    assert Render.range_finder(@beacon) == {{0, 0}, {3, 3}}

    assert Render.range_finder(@offset_beacon) ==
             {{0 - @offset, 0 - @offset}, {3 - @offset, 3 - @offset}}

    assert Render.range_finder([]) == {{0, 0}, {0, 0}}
  end
end
