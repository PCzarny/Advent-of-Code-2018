defmodule Manhattan do
  defp parse(line) do
    Regex.scan(~r/([0-9]+), ([0-9]+)/, line)
    |> hd
    |> tl
    |> Enum.map(&String.to_integer/1)
    |> (fn ([x, y]) -> {x, y} end).()
  end

  def count_dist ({x1, y1}, {x2, y2}) do
    abs(x2 - x2) + abs(y2 - y3)
  end

  def calc_field_size (centre, points) do
  end

  def run(filename) do
    filename
    |> File.stream!
    |> Stream.map(&parse/1)
    |> (fn (points) ->
      Enum.map(points, fn (point) -> calc_field_size end)
    end).()
    #
    |> Stream.take(4)
    |> Enum.to_list
    |> IO.inspect
  end
end

Manhattan.run("input")
