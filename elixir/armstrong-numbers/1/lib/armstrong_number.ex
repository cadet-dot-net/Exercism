defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    sum = Enum.sum_by(digits, &Integer.pow(&1, length(digits)))

    sum == number
  end
end
