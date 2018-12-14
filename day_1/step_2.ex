defmodule Duplicates do
  def find_duplicate (filename) do
    File.stream!(filename)
      |> Stream.map(fn line -> line |> Integer.parse() |> elem(0) end)
      |> Stream.cycle
      |> Enum.reduce_while({ 0, %{} }, fn (number, { acc, checked }) ->
        next = number + acc
        if (Map.has_key?(checked, next)) do
          {:halt, { next, Map.put(checked, next, true) }}
        else
          {:cont, { next, Map.put(checked, next, true) }}
        end
      end)
      |> elem(0)
      |> IO.puts
  end
end

Duplicates.find_duplicate("input")
