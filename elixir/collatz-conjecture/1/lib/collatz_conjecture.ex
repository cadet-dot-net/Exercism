defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer(), count :: non_neg_integer()) :: non_neg_integer()
  def calc(_input, count \\ 0)
  def calc(input, count) when input == 1, do: count
  def calc(input, count), do: input |> operate() |> trunc() |> calc(count + 1)

  @spec operate(n :: pos_integer()) :: float()
  def operate(n) when rem(n, 2) == 0 and n > 0, do: n / 2
  def operate(n) when rem(n, 2) != 0 and n > 0, do: (3*n) + 1
end
