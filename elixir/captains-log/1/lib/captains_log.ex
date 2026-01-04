defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-#{rand_in_range(1000, 9999)}"
  end

  def random_stardate() do
    :rand.uniform_real() + 41_000
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate]) |> List.to_string()
  end

  defp rand_in_range(num1, num2) do
    :rand.uniform(num2 - num1 + 1) + num1 - 1
  end
end
