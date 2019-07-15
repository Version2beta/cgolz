defmodule Cgolz.Helpers do
  @doc """
  randomize_campground(x, y)

  Generate a random grid for testing. The grid will go from -x to x, and -y to y.
  """

  @spec randomize_campground(range_x :: integer(), range_y :: integer(), density :: number()) ::
          Sites.state()
  def randomize_campground(range_x, range_y, density \\ 0.25) do
    for x <- 0..range_x, y <- 0..range_y do
      :rand.uniform() < density && {x, y}
    end
    |> Enum.filter(& &1)
  end
end
