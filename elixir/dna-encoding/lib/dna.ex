defmodule DNA do
  @dna %{
    ?\s => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }

  def encode_nucleotide(code_point), do: @dna[code_point]

  def decode_nucleotide(dna \\ @dna, code)

  def decode_nucleotide(dna, code) when is_map(dna), do: decode_nucleotide(Map.to_list(dna), code)
  def decode_nucleotide([{key, code} | _tail], code), do: key
  def decode_nucleotide([_head | tail], code), do: decode_nucleotide(tail, code)
  def decode_nucleotide([], _code), do: nil

  def encode([]), do: <<>>
  def encode([code | tail]), do: <<encode_nucleotide(code)::4, encode(tail)::bitstring>>

  def decode(<<>>), do: []
  def decode(<<head::4, tail::bitstring>>), do: [decode_nucleotide(head) | decode(tail)]
end
