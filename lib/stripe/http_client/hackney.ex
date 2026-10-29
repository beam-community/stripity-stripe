defmodule Stripe.HTTPClient.Hackney do
  @moduledoc """
  The default `Stripe.HTTPClient`, backed by [hackney](https://hex.pm/packages/hackney).

  ## Configuration

    * `:hackney_opts` – options added to every request, e.g. timeouts:

          config :stripity_stripe, hackney_opts: [{:connect_timeout, 1000}, {:recv_timeout, 5000}]

    * `:use_connection_pool` and `:pool_options` – see "HTTP Connection Pool" in `Stripe`. The
      pool is a `:hackney_pool` named `Stripe.API`.

    * `:http_module` – the module whose `request/5` is called in place of `:hackney.request/5`.
      It receives hackney's arguments and must return hackney's results. Mostly useful for
      tests.

  Options passed to individual `Stripe` calls that `Stripe.API` doesn't handle are passed on to
  hackney.
  """

  @behaviour Stripe.HTTPClient

  alias Stripe.Config

  @pool_name Stripe.API

  @impl Stripe.HTTPClient
  def request(method, url, headers, body, opts) do
    opts =
      opts
      |> add_default_options()
      |> add_pool_option()
      |> add_options_from_config()

    http_module().request(method, url, headers, body, opts)
  end

  @impl Stripe.HTTPClient
  def supervisor_children do
    if use_pool?() do
      [:hackney_pool.child_spec(@pool_name, Config.resolve(:pool_options))]
    else
      []
    end
  end

  @spec http_module() :: module
  defp http_module do
    Config.resolve(:http_module, :hackney)
  end

  @spec use_pool?() :: boolean
  defp use_pool? do
    Config.resolve(:use_connection_pool)
  end

  @spec add_default_options(list) :: list
  defp add_default_options(opts) do
    [:with_body | opts]
  end

  @spec add_pool_option(list) :: list
  defp add_pool_option(opts) do
    if use_pool?() do
      [{:pool, @pool_name} | opts]
    else
      opts
    end
  end

  @spec add_options_from_config(list) :: list
  defp add_options_from_config(opts) do
    if is_list(Config.resolve(:hackney_opts)) do
      opts ++ Config.resolve(:hackney_opts)
    else
      opts
    end
  end
end
