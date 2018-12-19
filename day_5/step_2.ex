defmodule Polymer do
  def react([], checked, false) do Enum.reverse(checked) end
  def react([a], checked, false) do Enum.reverse([a | checked]) end

  def react([], checked, true) do react(Enum.reverse(checked), [], false) end
  def react([a], checked, true) do react(Enum.reverse([a | checked]), [], false) end

  def react([a, b | tail], checked, edited) do
    if (abs(a - b) == 32) do
      react(tail, checked, true)
    else
      react([b | tail], [a | checked], edited)
    end
  end

  def clean(pollution, input) do
    input
    |> Enum.filter(fn letter ->
      diff = abs(letter - pollution)
      diff != 0 and diff != 32
    end)
    |> react([], false)
    |> length
  end

  def run(filename) do
    polymer = filename
    |> File.read!
    |> to_charlist

    # Nice feature - note
    ?A..?Z
    |> Enum.map(&(clean(&1, polymer)))
    |> Enum.min
    |> IO.inspect
  end
end

Polymer.run("input")
