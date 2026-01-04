defmodule LogLevel do
  @labels %{
    0 => [:trace, false],
    1 => [:debug, true],
    2 => [:info, true],
    3 => [:warning, true],
    4 => [:error, true],
    5 => [:fatal, false]
  }
  def to_label(level, legacy?) do
    cond do
      !(level in 0..5) -> :unknown
      level in 1..4 -> Enum.at(@labels[level], 0)
      legacy? == Enum.at(@labels[level], 1) -> Enum.at(@labels[level], 0)
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)
    cond do
      label == :error or label == :fatal -> :ops
      label == :unknown and legacy? -> :dev1
      label == :unknown -> :dev2
      true -> nil
    end
  end
end
