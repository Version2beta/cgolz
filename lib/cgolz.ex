defmodule Cgolz do
  @type site :: {integer, integer}
  @type camp :: [site]
  @type site_census :: {site, integer}
  @type census :: [site_census]

  @neighbors [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]

  @spec check_site(camp, site) :: :zombie | :brains
  def check_site(camp, site) do
    cond do
      site in camp -> :brains
      true -> :zombie
    end
  end

  @spec check_census(camp, site) :: integer()
  def check_census(camp, site) do
    {_, count} = Enum.find(camp, {site, 0}, fn {s, _} -> s == site end)
    count
  end

  @spec find_neighbors(site) :: [site]
  def find_neighbors({x, y}),
    do: Enum.map(@neighbors, fn {x_offset, y_offset} -> {x + x_offset, y + y_offset} end)

  @spec count_neighbors(camp, site) :: site_census
  def count_neighbors(camp, site) do
    neighbors =
      find_neighbors(site)
      |> Enum.filter(fn s -> check_site(camp, s) == :brains end)
      |> Enum.count()

    {site, neighbors}
  end

  @spec take_census(camp) :: census
  def take_census(camp) do
    Enum.reduce(camp, [], fn site, acc ->
      local_census = find_neighbors(site) |> Enum.map(&count_neighbors(camp, &1))
      local_census ++ acc
    end)
    |> Enum.uniq()
  end

  @spec tick(camp) :: camp
  def tick(camp) do
    take_census(camp)
    |> Enum.reduce([], fn
      {site, count}, acc ->
        cond do
          count == 2 and site in camp -> [site | acc]
          count == 3 -> [site | acc]
          true -> acc
        end
    end)
  end
end
