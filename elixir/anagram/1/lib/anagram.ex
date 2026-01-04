defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.reject(&insensitive_match?(&1, base))
    |> Enum.filter(fn candidate ->
      insensitive_char_freq(base) == insensitive_char_freq(candidate)
    end)
  end

  defp insensitive_match?(str1, str2) do
    String.downcase(str1) == String.downcase(str2)
  end

  defp insensitive_char_freq(str) do
    str
    |> String.downcase()
    |> String.codepoints()
    |> Enum.frequencies()
  end
end
