defmodule TakeANumber do
  def start(), do: spawn(fn -> loop(0) end)

  def loop(state) do
    receive do
      {:take_a_number, sender} ->
        send(sender, state + 1)
        loop(state + 1)

      {:report_state, sender} ->
        send(sender, state)
        loop(state)

      :stop ->
        :ok

      _ ->
        loop(state)
    end
  end
end
