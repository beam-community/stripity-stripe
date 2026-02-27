defmodule Stripe.HTTP do
  @moduledoc """
  Behaviour for HTTP clients used by Stripe.

  Stripity Stripe ships with two adapters:

    * `Stripe.HTTP.Hackney` — uses `:hackney` (the historical default)
    * `Stripe.HTTP.Req` — uses `Req` / Finch

  ## Choosing an adapter

  By default the library auto-detects which HTTP client is available
  at compile time. You can override this in your config:

      config :stripity_stripe, http_module: Stripe.HTTP.Req

  ## Implementing your own adapter

  Implement the two callbacks defined by this behaviour and set your
  module via the `:http_module` config key.
  """

  @type method :: :get | :post | :put | :delete | :patch
  @type headers :: [{String.t(), String.t()}]
  @type status :: non_neg_integer()

  @doc """
  Perform an HTTP request.

  The adapter must return the response body **decompressed** — each adapter
  is responsible for handling its own content-encoding.
  """
  @callback request(method, url :: String.t(), headers, body :: iodata() | {:multipart, list()}, opts :: list()) ::
              {:ok, status, headers, binary()} | {:error, term()}

  @doc """
  Return a list of child specs to be started under the Stripe supervisor.

  Return `[]` if the adapter does not need supervised processes (e.g. Req
  manages its own pool).
  """
  @callback supervisor_children() :: [Supervisor.child_spec()]

  @doc """
  Resolve which HTTP module to use.

  1. Checks the `:http_module` application config.
  2. Auto-detects hackney, then Req.
  3. Raises if neither is available.
  """
  @spec resolve_http_module() :: module()
  def resolve_http_module do
    case Stripe.Config.resolve(:http_module) do
      nil ->
        auto_detect_http_module()

      :hackney ->
        IO.warn(
          "Setting `config :stripity_stripe, http_module: :hackney` is deprecated. " <>
            "Use `Stripe.HTTP.Hackney` instead, or remove the setting to auto-detect."
        )

        Stripe.HTTP.Hackney

      module when is_atom(module) ->
        module
    end
  end

  defp auto_detect_http_module do
    cond do
      Code.ensure_loaded?(:hackney) ->
        Stripe.HTTP.Hackney

      Code.ensure_loaded?(Req) ->
        Stripe.HTTP.Req

      true ->
        raise """
        No HTTP client found. Stripity Stripe requires one of the following:

          # Option 1: hackney (traditional)
          {:hackney, "~> 1.18"}

          # Option 2: Req (modern, uses Finch under the hood)
          {:req, "~> 0.5"}

        Add one of the above to your mix.exs deps and run `mix deps.get`.
        """
    end
  end
end
