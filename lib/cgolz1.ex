defmodule Cgolz1 do
  @moduledoc """
  Rules:
  1. A camper with more than six zombie neighbors is overwhelmed, and becomes a zombie.
  2. A camper with more than three living neighbors parties too much, and becomes a zombie.
  3. A zombie with exactly three living neighbors is cured!
  """

  alias Cgolz.Sites

  def render(state, what \\ :occupants)

  def render(state, :occupants) do
    {range_x, range_y} = get_range(state)

    Enum.map((-1 * range_y)..range_y, fn y ->
      Enum.map((-1 * range_x)..range_x, fn x ->
        case Sites.check(state, {x, y}) do
          :brains -> " "
          :zombie -> "Z"
        end
      end)
      |> Enum.join("  ")
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def render(state, :neighbors) do
    census = Sites.take_census(state)
    {range_x, range_y} = get_range(census)

    Enum.map((-1 * range_y)..range_y, fn y ->
      Enum.map((-1 * range_x)..range_x, fn x ->
        Map.get(census, {x, y}, " ")
      end)
      |> Enum.join("  ")
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def get_range(state) do
    Map.keys(state)
    |> Enum.reduce({0, 0}, fn {x, y}, {max_x, max_y} ->
      {
        (abs(x) > max_x && abs(x)) || max_x,
        (abs(y) > max_y && abs(y)) || max_y
      }
    end)
  end

  @doc """
  tick(state)

  Advances the game one generation.
  """
  @spec tick(Sites.state()) :: Sites.state()
  def tick(state) do
    state
  end
end
