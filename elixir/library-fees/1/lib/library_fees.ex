defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime), do: datetime.hour < 12

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    Date.add(checkout_datetime, days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    late_days = Date.diff(actual_return_datetime, planned_return_date)
    if late_days < 1, do: 0, else: late_days
  end

  def monday?(datetime), do: Date.day_of_week(datetime) == 1

  def calculate_late_fee(checkout, return, rate) do
    return_dt = datetime_from_string(return)

    lateness =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(return_dt)

    fee = lateness * rate
    if monday?(return_dt), do: floor(fee * 0.5), else: fee
  end
end
