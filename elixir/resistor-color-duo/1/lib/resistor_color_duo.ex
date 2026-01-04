defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    bands = [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
    [c1, c2] = Enum.take(colors, 2)
    to_string(Enum.find_index(bands, fn x -> x == c1 end)) <>
    to_string(Enum.find_index(bands, fn x -> x == c2 end))
    |> String.to_integer()
  end
end
