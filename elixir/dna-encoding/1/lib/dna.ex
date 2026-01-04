defmodule DNA do
  @dna %{
    ?\s => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }

  def encode_nucleotide(code_point), do: @dna[code_point]

  def decode_nucleotide(encoded_code) do
    {codepoint, _idx} = Enum.find(@dna, fn {_key, val} -> val == encoded_code end)
    codepoint
  end

  def encode(dna) do
    dna
    |> Enum.map(fn acid -> <<encode_nucleotide(acid)::size(4)>> end)
    |> Enum.into(<<>>)
  end

  def decode(dna), do: Enum.map(value_bits(dna), fn b -> decode_nucleotide(b) end)

  def value_bits(<<>>), do: []
  def value_bits(<<head::4, tail::bitstring>>), do: [head | value_bits(tail)]
end
