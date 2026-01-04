defmodule HighScore do
  @reset_val 0

  def new(), do: %{}

  def add_player(scores, name, score \\ @reset_val) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name), do: Map.put(scores, name, @reset_val)

  def update_score(scores, name, score) do
    Map.update(scores, name, score,
      fn existing_value -> existing_value + score end)
  end

  def get_players(scores), do: Map.keys(scores)
end
