defmodule Stripe.FinancialConnections.Transaction do
  use Stripe.Entity

  @moduledoc "A Transaction represents a real transaction that affects a Financial Connections Account balance."
  (
    defstruct [
      :account,
      :amount,
      :currency,
      :description,
      :id,
      :livemode,
      :object,
      :status,
      :status_transitions,
      :transacted_at,
      :transaction_refresh,
      :updated
    ]

    @typedoc "The `financial_connections.transaction` type.\n\n  * `account` The ID of the Financial Connections Account this transaction belongs to.\n  * `amount` The amount of this transaction, in cents (or local equivalent).\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` The description of this transaction.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` The status of the transaction.\n  * `status_transitions` \n  * `transacted_at` Time at which the transaction was transacted. Measured in seconds since the Unix epoch.\n  * `transaction_refresh` The token of the transaction refresh that last updated or created this transaction.\n  * `updated` Time at which the object was last updated. Measured in seconds since the Unix epoch.\n"
    @type t :: %__MODULE__{
            account: binary,
            amount: integer,
            currency: binary,
            description: binary,
            id: binary,
            livemode: boolean,
            object: binary,
            status: binary,
            status_transitions: term,
            transacted_at: integer,
            transaction_refresh: binary,
            updated: integer
          }
  )

  (
    @typedoc nil
    @type transacted_at :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc nil
    @type transaction_refresh :: %{optional(:after) => binary}
  )

  (
    nil

    @doc "<p>Returns a list of Financial Connections <code>Transaction</code> objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/financial_connections/transactions`\n"
    (
      @spec list(
              params :: %{
                optional(:account) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:transacted_at) => transacted_at | integer,
                optional(:transaction_refresh) => transaction_refresh
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.FinancialConnections.Transaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/financial_connections/transactions",
            [],
            []
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

    @doc "<p>Retrieves the details of a Financial Connections <code>Transaction</code></p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/financial_connections/transactions/{transaction}`\n"
    (
      @spec retrieve(
              transaction :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.FinancialConnections.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/financial_connections/transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
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
