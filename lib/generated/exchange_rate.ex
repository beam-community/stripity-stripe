defmodule Stripe.ExchangeRate do
  use Stripe.Entity

  @moduledoc "`ExchangeRate` objects allow you to determine the rates that Stripe is currently\nusing to convert from one currency to another. Since this number is variable\nthroughout the day, there are various reasons why you might want to know the current\nrate (for example, to dynamically price an item for a user with a default\npayment in a foreign currency).\n\nPlease refer to our [Exchange Rates API](https://stripe.com/docs/fx-rates) guide for more details.\n\n*[Note: this integration path is supported but no longer recommended]* Additionally,\nyou can guarantee that a charge is made with an exchange rate that you expect is\ncurrent. To do so, you must pass in the exchange_rate to charges endpoints. If the\nvalue is no longer up to date, the charge won't go through. Please refer to our\n[Using with charges](https://stripe.com/docs/exchange-rates) guide for more details.\n\n-----\n\n&nbsp;\n\n*This Exchange Rates API is a Beta Service and is subject to Stripe's terms of service. You may use the API solely for the purpose of transacting on Stripe. For example, the API may be queried in order to:*\n\n- *localize prices for processing payments on Stripe*\n- *reconcile Stripe transactions*\n- *determine how much money to send to a connected account*\n- *determine app fees to charge a connected account*\n\n*Using this Exchange Rates API beta for any purpose other than to transact on Stripe is strictly prohibited and constitutes a violation of Stripe's terms of service.*"
  (
    defstruct [:id, :object, :rates]

    @typedoc "The `exchange_rate` type.\n\n  * `id` Unique identifier for the object. Represented as the three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) in lowercase.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `rates` Hash where the keys are supported currencies and the values are the exchange rate at which the base id currency converts to the key currency.\n"
    @type t :: %__MODULE__{id: binary, object: binary, rates: term}
  )

  (
    nil

    @doc "<p>Returns a list of objects that contain the rates at which foreign currencies are converted to one another. Only shows the currencies for which Stripe supports.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/exchange_rates`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.ExchangeRate.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/exchange_rates", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Retrieves the exchange rates from the given currency to every supported currency.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/exchange_rates/{rate_id}`\n"
    (
      @spec retrieve(
              rate_id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ExchangeRate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(rate_id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/exchange_rates/{rate_id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "rate_id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "rate_id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [rate_id]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
