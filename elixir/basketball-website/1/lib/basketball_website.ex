defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    [key | tail] = String.split(path, ".", parts: 2)

    case tail do
      [] -> data[key]
      [next_path] -> extract_from_path(data[key], next_path)
    end
  end

  def get_in_path(data, path), do: get_in(data, String.split(path, "."))
end
