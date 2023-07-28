defmodule Stripe.CashBalance do
  use Stripe.Entity

  @moduledoc "A customer's `Cash balance` represents real funds. Customers can add funds to their cash balance by sending a bank transfer. These funds can be used for payment and can eventually be paid out to your bank account."
  (
    defstruct [:available, :customer, :livemode, :object, :settings]

    @typedoc "The `cash_balance` type.\n\n  * `available` A hash of all cash balances available to this customer. You cannot delete a customer with any cash balances, even if the balance is 0. Amounts are represented in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `customer` The ID of the customer whose cash balance this object represents.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `settings` \n"
    @type t :: %__MODULE__{
            available: term | nil,
            customer: binary,
            livemode: boolean,
            object: binary,
            settings: term
          }
  )

  (
    @typedoc "A hash of settings for this cash balance."
    @type settings :: %{
            optional(:reconciliation_mode) => :automatic | :manual | :merchant_default
          }
  )

  (
    nil

    @doc "<p>Retrieves a customer’s cash balance.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/cash_balance`\n"
    (
      @spec retrieve(
              customer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CashBalance.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/cash_balance",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
          )

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

    @doc "<p>Changes the settings on a customer’s cash balance.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers/{customer}/cash_balance`\n"
    (
      @spec update(
              customer :: binary(),
              params :: %{optional(:expand) => list(binary), optional(:settings) => settings},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CashBalance.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/cash_balance",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end