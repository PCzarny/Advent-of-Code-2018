defmodule Checksum do
  defp count_letters (word) do
    word
      |> String.graphemes()
      |> Enum.reduce(%{}, fn (x, acc) -> Map.update(acc, x, 1, &(&1 + 1)) end)
      |> Map.values
  end

  def run (filename) do
    filename
      |> File.stream!
      |> Stream.map(&count_letters/1)
      |> Stream.map(&({ Enum.member?(&1, 2), Enum.member?(&1, 3)}))
      |> Enum.reduce({0, 0}, fn ({is_double, is_triple}, {double_sum, triple_sum}) ->
        {is_double && double_sum + 1 || double_sum, is_triple && triple_sum + 1 || triple_sum}
      end)
      |> (fn ({double_sum, triple_sum}) -> double_sum * triple_sum end).()
      |> IO.puts
  end
end

Checksum.run("input")
