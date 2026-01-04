defmodule KitchenCalculator do
  @units %{
    :milliliter => 1,
    :cup => 240,
    :fluid_ounce => 30,
    :teaspoon => 5,
    :tablespoon => 15
  }

  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) do
    {unit, volume} = volume_pair
    {:milliliter, volume * @units[unit]}
  end

  def from_milliliter(volume_pair, unit) do
    {unit, get_volume(volume_pair) / @units[unit]}
  end

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
