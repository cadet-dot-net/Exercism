defmodule Knapsack do
  @moduledoc """
  Return the maximum value that a knapsack can carry.
  """

  @doc """
  Check if a :knapsack ets table already exists and make a fresh one
  """
  defp set_table do
    if :ets.whereis(:knapsack) != :undefined, do: :ets.delete(:knapsack)
    :ets.new(:knapsack, [:bag, :named_table])
  end

  @doc """
  Run weight_combos/3 on 'items' from 1 to 'maximum_weight'
  Add each result to the ets table
  Get the maximum value out of all the weight combos
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value([], _maximum_weight), do: 0

  def maximum_value(items, maximum_weight) do
    if Enum.find(items, fn item -> item.weight <= maximum_weight end) do
      set_table()
      Enum.each(1..maximum_weight, fn w -> weight_combos(items, w) end)

      :ets.lookup(:knapsack, "weights")
      |> Enum.into([], fn {"weights", l} -> key_sum(l, :value) end)
      |> Enum.max()
    else
      0
    end
  end

  @doc """
  With 'partial' being elements in 'items' iterated over so far,
  and 's' being the sum of the weights of 'partial',
  return the possible combinations of elements that have a sum 's'
  that is equal to or less than the target number.
  This value is stored in an ets table so that it can be accessed globally.
  """
  defp weight_combos(items, target, partial \\ []) do
    s = partial |> key_sum(:weight)

    cond do
      s == target ->
        :ets.insert(:knapsack, {"weights", partial})

      s < target ->
        for {item, idx} <- Enum.with_index(items) do
          rest_of_items = -(length(items) - idx) + 1

          Enum.take(items, rest_of_items)
          |> weight_combos(target, partial ++ [item])
        end

      true ->
        nil
    end
  end

  @doc """
  Gets the sum of values of a specified key in a list of maps

  iex> Knapsack.key_sum([%{value: 5, weight: 2}, %{value: 21, weight: 10}], :weight)
  12
  """
  defp key_sum(items, key), do: items |> get_in([Access.all(), key]) |> Enum.sum()
end
