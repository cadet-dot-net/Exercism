defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]
  @default_histogram %{?A => 0, ?C => 0, ?G => 0, ?T => 0}

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    Enum.count(strand, &(&1 == nucleotide))
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    strand
    |> Enum.frequencies()
    |> then(&Map.merge(@default_histogram, &1))
    |> validate_chemicals()
  end

  defp validate_chemicals(frequencies) do
    chemicals = Map.keys(frequencies)

    if Enum.sort(chemicals) == @nucleotides, do: frequencies, else: :error
  end
end
