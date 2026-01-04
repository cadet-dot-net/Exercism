defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery}) do
    "Battery at #{battery}%"
  end

  def drive(remote_car = %RemoteControlCar{battery_percentage: 0}) do
    remote_car
  end

  def drive(remote_car = %RemoteControlCar{}) do
    battery = remote_car.battery_percentage
    distance = remote_car.distance_driven_in_meters

    %{remote_car | battery_percentage: battery - 1, distance_driven_in_meters: distance + 20}
  end
end
