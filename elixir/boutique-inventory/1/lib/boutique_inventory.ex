defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1.price)

  def with_missing_price(inventory), do: Enum.filter(inventory, &is_nil(&1.price))

  def update_names(inventory, old_word, new_word) do
    for i <- inventory do
      Map.update!(i, :name, &String.replace(&1, old_word, new_word))
    end
  end

  def increase_quantity(item, count) do
    q = Enum.into(item.quantity_by_size, %{}, fn {k, v} -> {k, v + count} end)
    %{item | quantity_by_size: q}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {k, v}, acc -> v + acc end)
  end
end
