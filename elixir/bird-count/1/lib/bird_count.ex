defmodule BirdCount do
  def today(list) do
    List.first(list)
  end

  def increment_day_count(list) do
    case today(list) do
      nil -> [1 | list]
      _ -> List.replace_at(list, 0, today(list) + 1)
    end
  end

  def has_day_without_birds?(list) do
    0 in list
  end

  def total(list) do
    Enum.sum(list)
  end

  def busy_days(list) do
    Enum.count(list, fn x -> x > 4 end)
  end
end
