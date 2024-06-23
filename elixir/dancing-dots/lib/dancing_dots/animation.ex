defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      @impl DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) == 0,
    do: %{dot | opacity: dot.opacity / 2}

  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts), do: validate_velocity(opts[:velocity], opts)

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts),
    do: %{dot | radius: dot.radius + (frame_number - 1) * opts[:velocity]}

  defp error_message(value),
    do: "The :velocity option is required, and its value must be a number. Got: #{inspect(value)}"

  defp validate_velocity(velocity, opts) when is_number(velocity), do: {:ok, opts}
  defp validate_velocity(velocity, _opts), do: {:error, error_message(velocity)}
end
