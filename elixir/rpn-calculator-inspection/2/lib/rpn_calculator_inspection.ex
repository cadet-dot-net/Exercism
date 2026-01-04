defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    {:ok, pid} = Task.start_link(fn -> calculator.(input) end)
    %{pid: pid, input: input}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} ->
        Map.put(results, input, :ok)

      {:EXIT, ^pid, _reason} ->
        Map.put(results, input, :error)
    after
      100 ->
        Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    flag = Process.flag(:trap_exit, true)

    results =
      inputs
      |> Enum.map(&start_reliability_check(calculator, &1))
      |> Enum.flat_map(&await_reliability_check_result(&1, %{}))
      |> Map.new()

    Process.flag(:trap_exit, flag)

    results
  end

  def correctness_check(calculator, inputs) do
    tasks = Enum.map(inputs, &Task.async(fn -> calculator.(&1) end))

    Task.await_many(tasks, 100)
  end
end
