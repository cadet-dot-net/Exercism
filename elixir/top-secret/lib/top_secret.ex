defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({type, _, _} = ast, acc) when type in [:def, :defp],
    do: {ast, [first_n_chars(ast_fa(ast)) | acc]}

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    defs = string |> to_ast() |> get_defs([])

    Enum.reduce(defs, [], fn line, acc ->
      {_ast, message} = decode_secret_message_part(line, acc)
      to_string(message)
    end)
  end

  defp get_defs(ast, acc) do
    {_, result} =
      Macro.prewalk(ast, acc, fn
        block = {type, _, _}, acc when type in [:def, :defp] -> {block, [block | acc]}
        other, acc -> {other, acc}
      end)

    result
  end

  defp ast_fa({_, _, [{:when, _, [{name, _, args} | _]} | _]}),
    do: {to_string(name), length(args || [])}

  defp ast_fa({_, _, [{name, _, args} | _]}), do: {to_string(name), length(args || [])}

  defp first_n_chars({str, n}) when n > 0, do: String.slice(str, 0..(n - 1))
  defp first_n_chars({_, _}), do: ""
end
