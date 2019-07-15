defmodule Cgolz.Render do
  def run(campground, opts \\ []) do
    {{min_x1, min_y1}, {max_x1, max_y1}} = range_finder(campground)
    IO.ANSI.clear() |> IO.write()

    final_campground =
      Enum.reduce(
        1..Keyword.get(opts, :generations, 10),
        {campground, {{min_x1, min_y1}, {max_x1, max_y1}}},
        fn g, {current, {{min_x, min_y}, {max_x, max_y}}} ->
          IO.ANSI.home() |> IO.write()
          IO.puts("Generation #{g} - #{max_x - min_x + 1} x #{max_y - min_y + 1}")

          render_campground(current, {{min_x, min_y}, {max_x, max_y}})
          |> IO.puts()

          :timer.sleep(Keyword.get(opts, :wait, 500))

          next = Cgolz.tick(current)
          {{new_min_x, new_min_y}, {new_max_x, new_max_y}} = range_finder(next)

          {
            next,
            {
              {min(new_min_x, min_x), min(new_min_y, min_y)},
              {max(new_max_x, max_x), max(new_max_y, max_y)}
            }
          }
        end
      )

    with {[], _} <- final_campground do
      :smooooores!
    else
      _ ->
        :braaaaaaaains!
    end
  end

  def render(source, fun), do: render(source, range_finder(source), fun)

  def render(source, {{min_x, min_y}, {max_x, max_y}}, fun) do
    for y <- min_y..max_y do
      for x <- min_x..max_x do
        fun.(source, {x, y})
      end
      |> Enum.join("")
    end
    |> Enum.join("\n")
  end

  def render_campground(campground, size \\ nil) do
    render(
      campground,
      size || range_finder(campground),
      &((Cgolz.check_site(&1, &2) == :zombie && "🧟") || "🧠")
    )
  end

  def render_census(campground) do
    Cgolz.take_census(campground)
    |> render(&Cgolz.check_census/2)
  end

  def range_finder([{{_, _}, _} | _] = census) do
    Enum.map(census, fn {{x, y}, _count} -> {x, y} end)
    |> range_finder()
  end

  def range_finder([h | _] = campground) do
    Enum.reduce(campground, {h, h}, fn {x, y}, {{min_x, min_y}, {max_x, max_y}} ->
      {
        {min(x, min_x), min(y, min_y)},
        {max(x, max_x), max(y, max_y)}
      }
    end)
  end

  def range_finder([]), do: {{0, 0}, {0, 0}}
end
