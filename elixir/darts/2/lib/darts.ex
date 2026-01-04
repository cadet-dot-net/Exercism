defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    case x**2 + y**2 do
      r2 when r2 > 100 -> 0 # outside target
      r2 when r2 > 25 and r2 <= 100 -> 1 # outer circle
      r2 when r2 > 1 and r2 <= 25 -> 5 # middle circle
      r2 when r2 >= 0 and r2 <= 1 -> 10  # inner circle
    end
  end
end
