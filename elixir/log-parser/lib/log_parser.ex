defmodule LogParser do
  def valid_line?(line), do: line =~ ~r/^\[(?:DEBUG|INFO|WARNING|ERROR)\]/

  def split_line(line), do: String.split(line, ~r/<[~*=-]*>/)

  def remove_artifacts(line), do: String.replace(line, ~r/end-of-line\d+/i, "")

  def tag_with_user_name(line), do: parse_captures(line, Regex.run(~r/User\s+([\S]+)/, line))

  defp parse_captures(line, [_ | [tag]]), do: "[USER] " <> tag <> " " <> line
  defp parse_captures(line, _captures), do: line
end
