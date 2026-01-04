defmodule Username do
  def sanitize(''), do: ''
  def sanitize([head | tail]) do
    sanitized =
      case head do
        ?ß -> 'ss'
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?_ -> '_'
        ch when ch in ?a..?z -> [ch]
        _ -> ''
      end

    sanitized ++ sanitize(tail)
  end
end
