defmodule Guard do
  defp parse(line) do
    [[_, yy, mm, dd, hh, min, msg]] = Regex.scan(~r/\[([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+)\] (.*)/, line)
    {y, mm, dd, hh, min, msg}
  end

  def run(filename) do
    filename
    |> File.stream!
    |> Stream.map(&parse/1)
  end
end

Guard.run("input")
