defmodule ResistorColor do
  @doc """
  Return the value of a color band
  """
  @spec code(atom) :: integer()
  def code(color) do
    Enum.find_index([:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white], fn c -> c == color end)
  end
end
