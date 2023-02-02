defmodule Sublist do
  @moduledoc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  @doc """
    Check if a contains b

    ## Examples
    iex> Sublist.sublist?([1,2,3], [1,2])
    true

    iex> Sublist.sublist?([1,2], [])
    true

    iex> Sublist.sublist?([1], [1,2])
    false

    iex> Sublist.sublist?([1,2,3], [1,2,3])
    false
  """

  def sublist?(_list1, []), do: true

  def sublist?(list1, list2) do
    list2 = Enum.join(list2, ",")

    ["[#{list2},", ",#{list2},", ",#{list2}]"]
    |> Enum.any?(fn x -> String.contains?("[#{Enum.join(list1, ",")}]", x) end)
  end

  def compare(a, a), do: :equal
  
  def compare(a, b) do
    cond do
      sublist?(a, b) -> :superlist
      sublist?(b, a) -> :sublist
      true -> :unequal
    end
  end
end
