# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(fn -> {0, opts} end)

  def list_registrations(pid), do: Agent.get(pid, fn {_counter, garden} -> garden end)

  def register(pid, register_to) do
    incr = get_counter(pid) + 1
    plot = %Plot{plot_id: incr, registered_to: register_to}

    Agent.update(pid, fn {_, garden} -> {incr, garden ++ [plot]} end)
    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {counter, garden} ->
      {counter, Enum.reject(garden, fn plot -> plot.plot_id == plot_id end)}
    end)
  end

  def get_registration(pid, plot_id) do
    Enum.find(list_registrations(pid), {:not_found, "plot is unregistered"}, fn plot ->
      plot.plot_id == plot_id
    end)
  end

  defp get_counter(pid) do
    Agent.get(pid, fn {counter, _} -> counter end)
  end
end
