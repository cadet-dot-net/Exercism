defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @bands [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    [c1, c2, c3] = band_idx(colors)
    resistance = (c1 * 10 + c2) * 10 ** c3

    case rem(resistance, 1000) == 0 do
      true -> {resistance / 1000, :kiloohms}
      _ -> {resistance, :ohms}
    end
  end

  @spec band_idx(color_list :: [atom]) :: [integer]
  def band_idx(color_list), do: Enum.map(color_list, fn x -> Enum.with_index(@bands)[x] end)
end
