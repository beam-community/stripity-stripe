defmodule Stripe.OpenApi do
  @moduledoc false

  alias Stripe.OpenApi

  defmacro __using__(opts) do
    opts = Keyword.put_new(opts, :base_module, Stripe)

    quote do
      @pipeline Stripe.OpenApi.pipeline(unquote(opts))

      {:ok, blueprint} = Stripe.OpenApi.run(@pipeline)

      @version blueprint.api_version

      @typedoc "Stripe config"
      @type t :: %__MODULE__{
              version: binary(),
              api_key: binary(),
              idempotency_key: nil | binary(),
              max_network_retries: pos_integer(),
              user_agent: binary(),
              base_url: binary(),
              http_client: term
            }

      defstruct [
        :version,
        :api_key,
        idempotency_key: nil,
        max_network_retries: 3,
        user_agent: "stripity-stripe",
        base_url: unquote(opts[:base_url]),
        http_client: Stripe.Request
      ]

      @doc """
      Returns new client.

      #### Options

        * `:version` Set Stripe api version. All requests use your account API settings, unless you override the API version.
        * `:api_key` Set Stripe api keys. Test mode secret keys have the prefix `sk_test_` and live mode secret keys have the prefix `sk_live_`.
        * `:idempotency_key` Override default idempotency key
        * `:base_url` Override default base url. E.g. for local testing
        * `:http_client` Override http client, defaults to Stripe.HTTPClient.HTTPC. Must conform to Stripe.HTTPClient behaviour.

      #### Example
      ```elixir
      client = Stripe.new()
      Stripe.Customer.create(client, %{description: "a description"})

      """
      @spec new(Keyword.t()) :: __MODULE__.t()
      def new(opts) do
        client = struct!(__MODULE__, opts)
        client
      end
    end
  end

  def pipeline(options \\ []) do
    [
      {OpenApi.Phases.Parse, options},
      {OpenApi.Phases.BuildModules, options},
      {OpenApi.Phases.BuildOperations, options},
      {OpenApi.Phases.BuildDocumentation, options},
      {OpenApi.Phases.Compile, options},
      {OpenApi.Phases.Version, options}
    ]
  end

  def run(pipeline) do
    {:ok, _} =
      pipeline
      |> List.flatten()
      |> run_phase(%OpenApiGen.Blueprint{})
  end

  defp run_phase(pipeline, input)

  defp run_phase([], input) do
    {:ok, input}
  end

  defp run_phase([phase_config | todo], input) do
    {phase, options} = phase_invocation(phase_config)

    case phase.run(input, options) do
      {:ok, result} ->
        run_phase(todo, result)

      {:error, message} ->
        {:error, message}

      _ ->
        {:error, "Last phase did not return a valid result tuple."}
    end
  end

  defp phase_invocation({phase, options}) when is_list(options) do
    {phase, options}
  end

  defp phase_invocation(phase) do
    {phase, []}
  end
end
