defmodule Stripe do
  @moduledoc """
  A HTTP client for Stripe.

  ## Configuration

  ### API Key

  You need to set your API key in your application configuration. Typically
  this is done in `config/config.exs` or a similar file. For example:

      config :stripity_stripe, api_key: "sk_test_abc123456789qwerty"

  You can also utilize `System.get_env/1` to retrieve the API key from
  an environment variable, but remember that this can cause issues if
  you use a release tool like exrm or Distillery.

      config :stripity_stripe, api_key: System.get_env("STRIPE_API_KEY")

  ### Shared Options

  Almost all of the requests that can be sent accept the following options:

    * `:api_key` - The Stripe API key to use for the request. See
      [https://stripe.com/docs/api/authentication](https://stripe.com/docs/api/authentication)
    * `:api_version` - The version of the api that is being used, defaults to the
      version the library is written for. See [https://stripe.com/docs/api/versioning](https://stripe.com/docs/api/versioning)
    * `:connect_account` - The ID of a Stripe Connect account for which the
      request should be made, passed through as the "Stripe-Account" header. The
      preferred authentication method for Stripe Connect. See
      [https://stripe.com/docs/connect/authentication#stripe-account-header](https://stripe.com/docs/connect/authentication#stripe-account-header)
    * `:expand` - Takes a list of fields that should be expanded in the response
      from Stripe. See [https://stripe.com/docs/api/expanding_objects](https://stripe.com/docs/api/expanding_objects)
    * `:idempotency_key` - A string that is passed through as the "Idempotency-Key" header on all POST requests. This is used by Stripe's idempotency layer to manage
      duplicate requests to the stripe API. See [https://stripe.com/docs/api/idempotent_requests](https://stripe.com/docs/api/idempotent_requests)
    * `:response_as` - Controls the format of the response. Accepts `:struct`
      (default), `:map`, or `:raw`. `:struct` converts the response into typed
      Stripe structs. `:map` returns the decoded response as a plain map with
      string keys, useful for serializing and storing the response; later you can
      convert it back with `Stripe.Converter.convert_result/1`. `:raw` returns
      the raw JSON string.

  ### Request options

  Requests are made with `Req`, which pools connections through `Finch` by
  default. Any `Req` option can be set for every request through the
  `:req_options` key in your application configuration:

      config :stripity_stripe, :req_options,
        receive_timeout: 5_000,
        finch: [size: 10]

  """

  @type id :: String.t()
  @type search_query :: String.t()
  @type date_query :: %{
          optional(:gt) => timestamp,
          optional(:gte) => timestamp,
          optional(:lt) => timestamp,
          optional(:lte) => timestamp
        }
  @type integer_query :: %{
          optional(:gt) => integer,
          optional(:gte) => integer,
          optional(:lt) => integer,
          optional(:lte) => integer
        }
  @type options :: Keyword.t()
  @type response_as :: :struct | :map | :raw
  @type timestamp :: pos_integer
end
