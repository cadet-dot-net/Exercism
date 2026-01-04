defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, opts \\ []) do
    max_price = opts[:maximum_price] || 100.00

    for t <- tops,
        b <- bottoms,
        t.base_color != b.base_color,
        t.price + b.price <= max_price,
        do: {t, b}
  end
end
