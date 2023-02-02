defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: hourly_rate * 8.0

  def apply_discount(before_discount, discount) do
    before_discount * (100 - discount) / 100
  end

  def monthly_rate(hourly_rate, discount) do
    total = daily_rate(hourly_rate) * 22
    apply_discount(total, discount) |> Float.ceil() |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    max_days = budget / apply_discount(daily_rate(hourly_rate), discount)
    Float.floor(max_days, 1)
  end
end
