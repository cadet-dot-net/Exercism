defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0,
    do: {:error, "all side lengths must be positive"}

  def kind(a, b, c) do
    if is_triangle?(a, b, c) do
      cond do
        a == b and b == c -> {:ok, :equilateral}
        has_duplicates?([a, b, c]) -> {:ok, :isosceles}
        true -> {:ok, :scalene}
      end
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end

  def is_triangle?(a, b, c) do
    a + b >= c and
      b + c >= a and
      a + c >= b
  end

  def has_duplicates?(list), do: Enum.uniq(list) != list
end
