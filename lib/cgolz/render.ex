defmodule Cgolz.Render do
  def run(camp, opts \\ []) do
    Enum.reduce(1..Keyword.get(opts, :generations, 10), camp, fn g, current ->
      IO.puts("\nGeneration #{g}")
      render_camp(current)
      :timer.sleep(Keyword.get(opts, :wait, 500))
      Cgolz.tick(current)
    end)

    :ok
  end

  def render(source, fun) do
    {{min_x, min_y}, {max_x, max_y}} = range_finder(source)

    for y <- min_y..max_y do
      for x <- min_x..max_x do
        fun.(source, {x, y})
      end
      |> Enum.join("  ")
    end
    |> Enum.join("\n")
    |> IO.puts()
  end

  def render_camp(camp, show \\ :brains) do
    render(camp, &((Cgolz.check_site(&1, &2) == show && "X") || " "))
  end

  def render_census(camp) do
    Cgolz.take_census(camp)
    |> render(&Cgolz.check_census/2)
  end

  def range_finder([{{_, _}, _} | _] = census) do
    Enum.map(census, fn {{x, y}, _count} -> {x, y} end)
    |> range_finder()
  end

  def range_finder([h | _] = camp) do
    Enum.reduce(camp, {h, h}, fn {x, y}, {{min_x, min_y}, {max_x, max_y}} ->
      {
        {min(x, min_x), min(y, min_y)},
        {max(x, max_x), max(y, max_y)}
      }
    end)
  end

  def range_finder([]), do: {{0, 0}, {0, 0}}
end
