defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    {n1, d1} = a
    {n2, d2} = b
    {n1 * d2 + n2 * d1, d1 * d2} |> reduce()
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    {n1, d1} = a
    {n2, d2} = b
    {n1 * d2 - n2 * d1, d1 * d2} |> reduce()
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    {n1, d1} = a
    {n2, d2} = b
    {n1 * n2, d1 * d2} |> reduce()
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(_num, {0, _}), do: :error

  def divide_by(num, den) do
    {n1, d1} = num
    {n2, d2} = den
    {n1 * d2, n2 * d1} |> reduce()
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    {n, d} = reduce(a)
    {Kernel.abs(n), Kernel.abs(d)}
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) do
    {num, den} = a

    cond do
      n >= 0 -> {num ** n, den ** n}
      true -> {den ** Kernel.abs(n), num ** Kernel.abs(n)}
    end
    |> reduce()
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {a, b} = reduce(n)
    :math.pow(x ** a, 1 / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({0, _d}), do: {0, 1}

  def reduce(a) do
    {n, d} = a
    divisor = gcd(n, d)
    {n, d} = {div(n, divisor), div(d, divisor)}

    cond do
      d < 0 -> {n * -1, d * -1}
      true -> {n, d}
    end
  end

  def gcd(a, b) do
    lowest = [a, b] |> Enum.min() |> Kernel.abs()
    divisors = Enum.filter(1..lowest, fn i -> {rem(a, i), rem(b, i)} == {0, 0} end)
    Enum.max(divisors)
  end
end
