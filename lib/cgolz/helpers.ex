defmodule Cgolz.Helpers do
  @doc """
  random_grid(x, y)

  Generate a random grid for testing. The grid will go from -x to x, and -y to y.
  """
  @spec random_grid(range_x :: integer(), range_y :: integer()) :: %{tuple => :zombie}
  def random_grid(range_x, range_y) do
    for x <- (-1 * range_x)..range_x, y <- (-1 * range_y)..range_y do
      Enum.random([false, true]) && {{x, y}, :zombie}
    end
    |> Enum.filter(& &1)
    |> Enum.into(%{})
  end

  @doc """
  random_cell(range_x, range_y)

  Pick a cell within a given range at random.
  """
  @spec random_cell(range_x :: integer, range_y :: integer) :: {integer, integer}
  def random_cell(range_x, range_y),
    do: {:rand.uniform(2 * range_x) - range_x, :rand.uniform(2 * range_y) - range_y}
end
