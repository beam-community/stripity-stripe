defmodule Stripe.Treasury.TransactionEntry do
  use Stripe.Entity

  @moduledoc "TransactionEntries represent individual units of money movements within a single [Transaction](https://stripe.com/docs/api#transactions)."
  (
    defstruct [
      :balance_impact,
      :created,
      :currency,
      :effective_at,
      :financial_account,
      :flow,
      :flow_details,
      :flow_type,
      :id,
      :livemode,
      :object,
      :transaction,
      :type
    ]

    @typedoc "The `treasury.transaction_entry` type.\n\n  * `balance_impact` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `effective_at` When the TransactionEntry will impact the FinancialAccount's balance.\n  * `financial_account` The FinancialAccount associated with this object.\n  * `flow` Token of the flow associated with the TransactionEntry.\n  * `flow_details` Details of the flow associated with the TransactionEntry.\n  * `flow_type` Type of the flow associated with the TransactionEntry.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `transaction` The Transaction associated with this object.\n  * `type` The specific money movement that generated the TransactionEntry.\n"
    @type t :: %__MODULE__{
            balance_impact: term,
            created: integer,
            currency: binary,
            effective_at: integer,
            financial_account: binary,
            flow: binary | nil,
            flow_details: term | nil,
            flow_type: binary,
            id: binary,
            livemode: boolean,
            object: binary,
            transaction: binary | Stripe.Treasury.Transaction.t(),
            type: binary
          }
  )

  (
    @typedoc nil
    @type created :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc nil
    @type effective_at :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    nil

    @doc "<p>Retrieves a TransactionEntry object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/transaction_entries/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.TransactionEntry.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/transaction_entries/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [id]
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

    @doc "<p>Retrieves a list of TransactionEntry objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/transaction_entries`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:effective_at) => effective_at | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:limit) => integer,
                optional(:order_by) => :created | :effective_at,
                optional(:starting_after) => binary,
                optional(:transaction) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.TransactionEntry.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/transaction_entries", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
