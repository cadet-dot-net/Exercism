defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State

  # Client API

  @spec report_state(pid()) :: State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset)
  end

  # Server callbacks

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @impl GenServer
  def init(init_arg) do
    min = init_arg[:min_number]
    max = init_arg[:max_number]
    timeout = init_arg[:auto_shutdown_timeout] || :infinity

    case State.new(min, max, timeout) do
      {:ok, state} -> {:ok, state, timeout}
      {:error, reason} -> {:stop, reason}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  def handle_call(:queue, _from, %{auto_shutdown_timeout: timeout} = state) do
    case State.queue_new_number(state) do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, timeout}

      error ->
        {:reply, error, state, timeout}
    end
  end

  def handle_call(
        {:serve_next_queued, priority_number},
        _from,
        %{auto_shutdown_timeout: timeout} = state
      ) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, next, new_state} -> {:reply, {:ok, next}, new_state, timeout}
      error -> {:reply, error, state, timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, %{min_number: min, max_number: max, auto_shutdown_timeout: timeout}) do
    {:ok, new_state} = State.new(min, max, timeout)
    {:noreply, new_state, timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
