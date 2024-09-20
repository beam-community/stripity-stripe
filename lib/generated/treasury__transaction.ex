defmodule Stripe.Treasury.Transaction do
  use Stripe.Entity

  @moduledoc "Transactions represent changes to a [FinancialAccount's](https://stripe.com/docs/api#financial_accounts) balance."
  (
    defstruct [
      :amount,
      :balance_impact,
      :created,
      :currency,
      :description,
      :entries,
      :financial_account,
      :flow,
      :flow_details,
      :flow_type,
      :id,
      :livemode,
      :object,
      :status,
      :status_transitions
    ]

    @typedoc "The `treasury.transaction` type.\n\n  * `amount` Amount (in cents) transferred.\n  * `balance_impact` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `entries` A list of TransactionEntries that are part of this Transaction. This cannot be expanded in any list endpoints.\n  * `financial_account` The FinancialAccount associated with this object.\n  * `flow` ID of the flow that created the Transaction.\n  * `flow_details` Details of the flow that created the Transaction.\n  * `flow_type` Type of the flow that created the Transaction.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` Status of the Transaction.\n  * `status_transitions` \n"
    @type t :: %__MODULE__{
            amount: integer,
            balance_impact: term,
            created: integer,
            currency: binary,
            description: binary,
            entries: term | nil,
            financial_account: binary,
            flow: binary | nil,
            flow_details: term | nil,
            flow_type: binary,
            id: binary,
            livemode: boolean,
            object: binary,
            status: binary,
            status_transitions: term
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
    @type posted_at :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc nil
    @type status_transitions :: %{optional(:posted_at) => posted_at | integer}
  )

  (
    nil

    @doc "<p>Retrieves a list of Transaction objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/transactions`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:limit) => integer,
                optional(:order_by) => :created | :posted_at,
                optional(:starting_after) => binary,
                optional(:status) => :open | :posted | :void,
                optional(:status_transitions) => status_transitions
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.Transaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/transactions", [], [])

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

    @doc "<p>Retrieves the details of an existing Transaction.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/transactions/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/transactions/{id}",
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
end
