defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.from_index(2)
    |> Stream.filter(&prime?/1)
    |> Enum.at(count - 1)
  end

  defp prime?(2), do: true
  defp prime?(num), do: num > 1 and not composite?(num)

  defp composite?(num), do: Enum.any?(2..(num - 1), &(rem(num, &1) == 0))
end
