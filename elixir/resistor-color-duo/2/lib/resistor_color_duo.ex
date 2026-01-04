defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([c1, c2 | _]) do
    bands = [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
    Enum.find_index(bands, fn x -> x == c1 end) * 10 +
    Enum.find_index(bands, fn x -> x == c2 end)
  end
end
