defmodule Fabric do
  defp parse(line) do
    [[_ , id | match]] = Regex.scan(~r/(#[0-9]+) @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)/, line)
    [x, y, dx, dy] = Enum.map(match, &String.to_integer/1)
    {id, x, y, x + dx - 1, y + dy - 1}
  end

  def update_fabric({id, claim}, {fabric, cleans}) do
    if (Map.has_key?(fabric, claim)) do
      {fabric, Map.put(cleans, Map.get(fabric, claim), false) |> Map.put(id, false)}
    else
      {Map.put(fabric, claim, id), cleans}
    end
  end

  defp paint_fabric({id, x_min, y_min, x_max, y_max}, {fabric, cleans}) do
    for x <- x_min..x_max, y <- y_min..y_max do {x, y} end
      |> Enum.reduce({fabric, cleans |> Map.put(id, true)}, fn (claim, acc) ->
        update_fabric({id, claim}, acc)
      end)
  end

  def run(input) do
    input
      |> File.stream!
      |> Stream.map(&parse/1)
      |> Enum.reduce({%{}, %{}}, fn (coordinates, acc) ->
        paint_fabric(coordinates, acc)
      end)
      |> elem(1)
      |> Enum.to_list
      |> Enum.filter(fn {_, is_clean} -> is_clean end)
      |> List.first
      |> elem(0)
      |> IO.inspect
  end
end

Fabric.run("input")
