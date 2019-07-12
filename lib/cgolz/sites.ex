defmodule Cgolz.Sites do
  @moduledoc """
  Manages the grid of campsites
  """

  @neighbors [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]

  @type state :: %{tuple() => :zombie | :brains}

  @doc """
  check({x, y})

  See if the tent at x, y is occupied by Zombies or Campers.
  """
  @spec check(state :: state(), {x :: integer, y :: integer}) :: :zombie | :brains
  def check(state, {x, y}), do: Map.get(state, {x, y}, :brains)

  def offset({x, y}, {by_x, by_y}), do: {x + by_x, y + by_y}

  def count(state, {_x, _y} = site) do
    Enum.map(@neighbors, fn neighbor -> check(state, offset(site, neighbor)) end)
    |> Enum.filter(fn neighbor -> neighbor == :zombie end)
    |> Enum.count()
  end
end
