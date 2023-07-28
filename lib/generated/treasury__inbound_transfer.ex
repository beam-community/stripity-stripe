defmodule Stripe.Treasury.InboundTransfer do
  use Stripe.Entity

  @moduledoc "Use [InboundTransfers](https://stripe.com/docs/treasury/moving-money/financial-accounts/into/inbound-transfers) to add funds to your [FinancialAccount](https://stripe.com/docs/api#financial_accounts) via a PaymentMethod that is owned by you. The funds will be transferred via an ACH debit."
  (
    defstruct [
      :amount,
      :cancelable,
      :created,
      :currency,
      :description,
      :failure_details,
      :financial_account,
      :hosted_regulatory_receipt_url,
      :id,
      :linked_flows,
      :livemode,
      :metadata,
      :object,
      :origin_payment_method,
      :origin_payment_method_details,
      :returned,
      :statement_descriptor,
      :status,
      :status_transitions,
      :transaction
    ]

    @typedoc "The `treasury.inbound_transfer` type.\n\n  * `amount` Amount (in cents) transferred.\n  * `cancelable` Returns `true` if the InboundTransfer is able to be canceled.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `failure_details` Details about this InboundTransfer's failure. Only set when status is `failed`.\n  * `financial_account` The FinancialAccount that received the funds.\n  * `hosted_regulatory_receipt_url` A [hosted transaction receipt](https://stripe.com/docs/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.\n  * `id` Unique identifier for the object.\n  * `linked_flows` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `origin_payment_method` The origin payment method to be debited for an InboundTransfer.\n  * `origin_payment_method_details` Details about the PaymentMethod for an InboundTransfer.\n  * `returned` Returns `true` if the funds for an InboundTransfer were returned after the InboundTransfer went to the `succeeded` state.\n  * `statement_descriptor` Statement descriptor shown when funds are debited from the source. Not all payment networks support `statement_descriptor`.\n  * `status` Status of the InboundTransfer: `processing`, `succeeded`, `failed`, and `canceled`. An InboundTransfer is `processing` if it is created and pending. The status changes to `succeeded` once the funds have been \"confirmed\" and a `transaction` is created and posted. The status changes to `failed` if the transfer fails.\n  * `status_transitions` \n  * `transaction` The Transaction associated with this object.\n"
    @type t :: %__MODULE__{
            amount: integer,
            cancelable: boolean,
            created: integer,
            currency: binary,
            description: binary | nil,
            failure_details: term | nil,
            financial_account: binary,
            hosted_regulatory_receipt_url: binary | nil,
            id: binary,
            linked_flows: term,
            livemode: boolean,
            metadata: term,
            object: binary,
            origin_payment_method: binary,
            origin_payment_method_details: term | nil,
            returned: boolean | nil,
            statement_descriptor: binary,
            status: binary,
            status_transitions: term,
            transaction: (binary | Stripe.Treasury.Transaction.t()) | nil
          }
  )

  (
    @typedoc "Details about a failed InboundTransfer."
    @type failure_details :: %{
            optional(:code) =>
              :account_closed
              | :account_frozen
              | :bank_account_restricted
              | :bank_ownership_changed
              | :debit_not_authorized
              | :incorrect_account_holder_address
              | :incorrect_account_holder_name
              | :incorrect_account_holder_tax_id
              | :insufficient_funds
              | :invalid_account_number
              | :invalid_currency
              | :no_account
              | :other
          }
  )

  (
    nil

    @doc "<p>Cancels an InboundTransfer.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/inbound_transfers/{inbound_transfer}/cancel`\n"
    (
      @spec cancel(
              inbound_transfer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.InboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def cancel(inbound_transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/inbound_transfers/{inbound_transfer}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "inbound_transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "inbound_transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [inbound_transfer]
          )

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

    @doc "<p>Creates an InboundTransfer.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/inbound_transfers`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:origin_payment_method) => binary,
                optional(:statement_descriptor) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.InboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/inbound_transfers", [], [])

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

    @doc "<p>Retrieves the details of an existing InboundTransfer.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/inbound_transfers/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.InboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/inbound_transfers/{id}",
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

    @doc "<p>Returns a list of InboundTransfers sent from the specified FinancialAccount.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/inbound_transfers`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :canceled | :failed | :processing | :succeeded
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.InboundTransfer.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/inbound_transfers", [], [])

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

    @doc "<p>Transitions a test mode created InboundTransfer to the <code>succeeded</code> status. The InboundTransfer must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/inbound_transfers/{id}/succeed`\n"
    (
      @spec succeed(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.InboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def succeed(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/inbound_transfers/{id}/succeed",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Transitions a test mode created InboundTransfer to the <code>failed</code> status. The InboundTransfer must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/inbound_transfers/{id}/fail`\n"
    (
      @spec fail(
              id :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:failure_details) => failure_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.InboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def fail(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/inbound_transfers/{id}/fail",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Marks the test mode InboundTransfer object as returned and links the InboundTransfer to a ReceivedDebit. The InboundTransfer must already be in the <code>succeeded</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/inbound_transfers/{id}/return`\n"
    (
      @spec return_inbound_transfer(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.InboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def return_inbound_transfer(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/inbound_transfers/{id}/return",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end