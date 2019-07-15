# Cgolz - Conway's Game of Life, with Zombies

Standard Conway's Game of Life rules:

1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overpopulation.
4. Any dead cell with three live neighbours becomes a live cell, as if by reproduction.

(from [Wikipedia](https://en.wikipedia.org/wiki/Conway's_Game_of_Life#Rules))

Rules for Conway's Game of Life, with Zombies:

1. Any zombie with fewer than two neighboring zombie campers is overcome by the campers.
2. Any zombie with two or three neighboring zombie campers goes on the to next tick.
3. Any zombie with more than three zombie neighbours succombs to overpopulation.
4. Any campsite with exactly three zombie neighbours remains, or becomes, zombified.

How to run this version:

`Cgolz`, in `cgolz.ex`, contains various functions for understanding a game grid and advancing it one generation (`tick`).

`Cgolz.Render` offers a few basic tools for rendering a grid in IEx, and a `run` function that renders a grid across multiple generations with configurable delays between each generation.

Finally, `Cgolz.Helpers` offers a `random_grid` function providing a starting point.
