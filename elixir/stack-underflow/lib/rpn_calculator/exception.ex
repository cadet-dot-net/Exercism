defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @message "stack underflow occurred"
    defexception message: @message

    @impl true
    def exception([]), do: %StackUnderflowError{}
    def exception(context), do: %StackUnderflowError{message: "#{@message}, context: #{context}"}
  end

  def divide([]), do: raise(StackUnderflowError, "when dividing")
  def divide([_]), do: raise(StackUnderflowError, "when dividing")
  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([den, num]), do: num / den
end
