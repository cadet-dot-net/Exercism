defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class, do: Enum.random(@planetary_classes)

  def random_ship_registry_number, do: "NCC-#{Enum.random(1000..9999)}"

  def random_stardate, do: rand_in_range(41_000.0, 42_000.0)

  def format_stardate(stardate), do: :io_lib.format("~.1f", [stardate]) |> to_string()

  defp rand_in_range(num1, num2), do: :rand.uniform() * (num2 - num1) + num1
end
