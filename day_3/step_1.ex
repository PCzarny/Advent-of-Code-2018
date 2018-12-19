defmodule Fabric do
  defp parse(line) do
    [[_ | match]] = Regex.scan(~r/#[0-9]+ @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)/, line)
    [x, y, dx, dy] = Enum.map(match, &String.to_integer/1)
    {x, y, x + dx - 1, y + dy - 1}
  end

  defp paint_fabric({x_min, y_min, x_max, y_max}, fabric) do
    for x <- x_min..x_max, y <- y_min..y_max do {x, y} end
    |> Enum.reduce(fabric, fn (claim, acc) -> Map.update(acc, claim, 1, &(&1 + 1)) end)
  end

  def run(input) do
    input
      |> File.stream!
      |> Stream.map(&parse/1)
      |> Enum.reduce(%{}, fn (coordinates, fabric) ->
        paint_fabric(coordinates, fabric)
      end)
      |> Map.values
      |> Enum.count(fn x -> x > 1 end)
      |> IO.inspect
  end
end

Fabric.run("input")
