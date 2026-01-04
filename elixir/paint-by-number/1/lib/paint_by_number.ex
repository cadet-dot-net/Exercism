defmodule PaintByNumber do
  def palette_bit_size(color_count), do: log2(color_count)

  def empty_picture(), do: ""

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    pbs = palette_bit_size(color_count)
    <<pixel_color_index::size(pbs), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    {first, _} = split_pixels(picture, color_count)
    first
  end

  def drop_first_pixel(picture, color_count) do
    {_, rest} = split_pixels(picture, color_count)
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end

  defp log2(n) do
    if n <= 2 do
      1
    else
      1 + log2(n / 2)
    end
  end

  defp split_pixels(picture, color_count) do
    case picture do
      "" -> {nil, <<>>}
      _ ->
        pbs = palette_bit_size(color_count)
        <<first::size(pbs), rest::bitstring>> = picture
        {first, rest}
    end
  end
end
