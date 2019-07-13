defmodule Cgolz.Helpers do
  @doc """
  random_grid(x, y)

  Generate a random grid for testing. The grid will go from -x to x, and -y to y.
  """

  @spec random_grid(range_x :: integer(), range_y :: integer()) :: Sites.state()
  def random_grid(range_x, range_y) do
    for x <- 0..range_x, y <- 0..range_y do
      Enum.random([false, false, false, true]) && {x, y}
    end
    |> Enum.filter(& &1)
  end
end
