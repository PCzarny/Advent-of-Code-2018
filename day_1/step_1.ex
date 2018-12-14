File.stream!("input")
  |> Stream.map(fn line -> line |> Integer.parse() |> elem(0) end)
  |> Enum.reduce(0, fn (number, acc) -> acc + number end)
  |> IO.puts
