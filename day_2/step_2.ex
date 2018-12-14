defmodule Difference do
  defp is_similar(template, word) do
    case String.myers_difference(template, word) do
      [del: <<_::binary-size(1)>>, ins: <<_::binary-size(1)>>, eq: _] -> true
      [eq: _, del: <<_::binary-size(1)>>, ins: <<_::binary-size(1)>>, eq: _] -> true
      [eq: _, del: <<_::binary-size(1)>>, ins: <<_::binary-size(1)>>] -> true
      _ -> false
    end
  end

  defp find_similar(stream, template) do
    matching = Stream.filter(stream, fn word -> is_similar(template, word) end)
      |> Enum.to_list
    {template, matching}
  end

  def run (filename) do
    stream = filename
      |> File.stream!
      |> Stream.map(&String.trim/1)

    Stream.map(stream, &(find_similar(stream, &1)))
      |> Stream.filter(fn
          {_ , []} -> false
          _ -> true
        end)
      |> Stream.map(fn {template, [matched]} ->
        String.myers_difference(template, matched)
        |> Keyword.get_values(:eq)
        |> Enum.reduce(fn (x, acc) -> acc <> x end)
      end)
      |> Enum.to_list
      |> IO.inspect
  end
end

Difference.run("input")
