defmodule Stripe.Treasury.DebitReversal do
  use Stripe.Entity

  @moduledoc "You can reverse some [ReceivedDebits](https://stripe.com/docs/api#received_debits) depending on their network and source flow. Reversing a ReceivedDebit leads to the creation of a new object known as a DebitReversal."
  (
    defstruct [
      :amount,
      :created,
      :currency,
      :financial_account,
      :hosted_regulatory_receipt_url,
      :id,
      :linked_flows,
      :livemode,
      :metadata,
      :network,
      :object,
      :received_debit,
      :status,
      :status_transitions,
      :transaction
    ]

    @typedoc "The `treasury.debit_reversal` type.\n\n  * `amount` Amount (in cents) transferred.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `financial_account` The FinancialAccount to reverse funds from.\n  * `hosted_regulatory_receipt_url` A [hosted transaction receipt](https://stripe.com/docs/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.\n  * `id` Unique identifier for the object.\n  * `linked_flows` Other flows linked to a DebitReversal.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `network` The rails used to reverse the funds.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `received_debit` The ReceivedDebit being reversed.\n  * `status` Status of the DebitReversal\n  * `status_transitions` \n  * `transaction` The Transaction associated with this object.\n"
    @type t :: %__MODULE__{
            amount: integer,
            created: integer,
            currency: binary,
            financial_account: binary | nil,
            hosted_regulatory_receipt_url: binary | nil,
            id: binary,
            linked_flows: term | nil,
            livemode: boolean,
            metadata: term,
            network: binary,
            object: binary,
            received_debit: binary,
            status: binary,
            status_transitions: term,
            transaction: (binary | Stripe.Treasury.Transaction.t()) | nil
          }
  )

  (
    nil

    @doc "<p>Reverses a ReceivedDebit and creates a DebitReversal object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/debit_reversals`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:received_debit) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.DebitReversal.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/debit_reversals", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Retrieves a DebitReversal object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/debit_reversals/{debit_reversal}`\n"
    (
      @spec retrieve(
              debit_reversal :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.DebitReversal.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(debit_reversal, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/debit_reversals/{debit_reversal}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "debit_reversal",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "debit_reversal",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [debit_reversal]
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

    @doc "<p>Returns a list of DebitReversals.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/debit_reversals`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:limit) => integer,
                optional(:received_debit) => binary,
                optional(:resolution) => :lost | :won,
                optional(:starting_after) => binary,
                optional(:status) => :canceled | :completed | :processing
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.DebitReversal.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/debit_reversals", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end