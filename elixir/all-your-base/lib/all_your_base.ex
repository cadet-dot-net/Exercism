defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    case validate_args(digits, input_base, output_base) do
      "ok" ->
        {:ok,
         to_base10(digits, input_base) |> div_rem(output_base) |> from_base10(output_base, [])}

      msg ->
        {:error, msg}
    end
  end

  defp to_base10(digits, input_base) do
    Enum.with_index(digits, &{&1, length(digits) - 1 - &2})
    |> Enum.map(fn {d, i} -> d * input_base ** i end)
    |> Enum.sum()
  end

  defp from_base10({0, remainder}, _, result), do: [remainder | result]

  defp from_base10({n, remainder}, output_base, result),
    do: div_rem(n, output_base) |> from_base10(output_base, [remainder | result])

  defp div_rem(dividend, divisor), do: {div(dividend, divisor), rem(dividend, divisor)}

  defp validate_args(_, input_base, _) when input_base < 2, do: "input base must be >= 2"
  defp validate_args(_, _, output_base) when output_base < 2, do: "output base must be >= 2"

  defp validate_args(digits, input_base, output_base),
    do: validate_digits(digits, input_base, output_base)

  defp validate_digits([], _, _), do: "ok"

  defp validate_digits([d | _], input_base, _) when d < 0 or d >= input_base,
    do: "all digits must be >= 0 and < input base"

  defp validate_digits([_ | rest], input_base, output_base),
    do: validate_digits(rest, input_base, output_base)
end
