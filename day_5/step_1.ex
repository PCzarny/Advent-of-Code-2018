defmodule Polymer do
  def x([], checked, false) do checked end
  def x([a], checked, false) do [a | checked] end

  def x([], checked, true) do x(Enum.reverse(checked), [], false) end
  def x([a], checked, true) do x(Enum.reverse([a | checked]), [], false) end

  def x([a, b | tail], checked, edited) do
    if (abs(a - b) == 32) do
      x(tail, checked, true)
    else
      x([b | tail], [a | checked], edited)
    end
  end

  def run(filename) do
    filename
    |> File.read!
    |> to_charlist
    |> x([], false)
    |> Enum.reverse
    |> length
    |> IO.inspect
  end
end

Polymer.run("input")
