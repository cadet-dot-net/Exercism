defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, low \\ nil, high \\ nil, key)
  def search({}, _low, _high, _key), do: :not_found
  def search({key}, _low, _high, key), do: {:ok, 0}

  def search(numbers, low, high, key) do
    [l, h] = [low || 0, high || tuple_size(numbers) - 1]
    idx = round((h + l) / 2)
    mid = elem(numbers, idx)

    cond do
      key not in Tuple.to_list(numbers) -> :not_found
      key == mid -> {:ok, idx}
      key < mid -> search(numbers, l, idx - 1, key)
      key > mid -> search(numbers, idx + 1, h, key)
    end
  end
end
