defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    num_of_digits = length(digits)

    sum =
      digits
      |> Enum.map(&Integer.pow(&1, num_of_digits))
      |> Enum.sum()

    sum == number
  end
end
