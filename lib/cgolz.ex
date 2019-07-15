defmodule Cgolz do
  @moduledoc """

  """
  @type campsite :: {integer, integer}
  @type campground :: [campsite]
  @type site_census :: {campsite, integer}
  @type census :: [site_census]

  @neighbors [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]

  @spec tick(campground) :: campground
  def tick(campground) do
    take_census(campground)
    |> Enum.reduce([], fn
      {campsite, count}, acc ->
        cond do
          count == 2 and campsite in campground -> [campsite | acc]
          count == 3 -> [campsite | acc]
          true -> acc
        end
    end)
  end

  @spec check_census(campground, campsite) :: integer()
  def check_census(campground, campsite) do
    {_, count} = Enum.find(campground, {campsite, 0}, fn {site, _} -> site == campsite end)
    count
  end

  @spec take_census(campground) :: census
  def take_census(campground) do
    Enum.reduce(campground, [], fn campsite, acc ->
      local_census =
        find_neighbors(campsite)
        |> Enum.map(fn neighbor ->
          Enum.find(acc, count_neighbors(campground, neighbor), fn {site, _count} ->
            site == neighbor
          end)
        end)

      local_census ++ acc
    end)
    |> Enum.uniq()
  end

  @spec find_neighbors(campsite) :: [campsite]
  def find_neighbors({x, y}),
    do: Enum.map(@neighbors, fn {x_offset, y_offset} -> {x + x_offset, y + y_offset} end)

  @spec count_neighbors(campground, campsite) :: site_census
  def count_neighbors(campground, campsite) do
    neighbors_count =
      find_neighbors(campsite)
      |> Enum.filter(fn site -> check_site(campground, site) == :brains end)
      |> Enum.count()

    {campsite, neighbors_count}
  end

  @spec check_site(campground, campsite) :: :zombie | :brains
  def check_site(campground, campsite) do
    cond do
      campsite in campground -> :brains
      true -> :zombie
    end
  end
end
