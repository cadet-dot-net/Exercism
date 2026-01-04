defmodule NameBadge do
  def print(nil, name, department), do: "#{name} - " <> String.upcase(department || "owner")
  def print(id, name, department) do
    "[#{id}] - " <> "#{name} - " <> String.upcase(department || "owner")
  end
end
