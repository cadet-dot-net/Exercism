defmodule NameBadge do
  def print(id, name, department) do
    if id == nil do
      "#{name} - #{String.upcase(department || "owner")}"
    else
      "[#{id}] - #{name} - #{String.upcase(department || "owner")}"
    end
  end
end
 