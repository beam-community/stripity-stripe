defmodule Stripe.Treasury.OutboundTransfer do
  use Stripe.Entity

  @moduledoc "Use [OutboundTransfers](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-transfers) to transfer funds from a [FinancialAccount](https://stripe.com/docs/api#financial_accounts) to a PaymentMethod belonging to the same entity. To send funds to a different party, use [OutboundPayments](https://stripe.com/docs/api#outbound_payments) instead. You can send funds over ACH rails or through a domestic wire transfer to a user's own external bank account.\n\nSimulate OutboundTransfer state changes with the `/v1/test_helpers/treasury/outbound_transfers` endpoints. These methods can only be called on test mode objects.\n\nRelated guide: [Moving money with Treasury using OutboundTransfer objects](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-transfers)"
  (
    defstruct [
      :amount,
      :cancelable,
      :created,
      :currency,
      :description,
      :destination_payment_method,
      :destination_payment_method_details,
      :expected_arrival_date,
      :financial_account,
      :hosted_regulatory_receipt_url,
      :id,
      :livemode,
      :metadata,
      :object,
      :returned_details,
      :statement_descriptor,
      :status,
      :status_transitions,
      :tracking_details,
      :transaction
    ]

    @typedoc "The `treasury.outbound_transfer` type.\n\n  * `amount` Amount (in cents) transferred.\n  * `cancelable` Returns `true` if the object can be canceled, and `false` otherwise.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `destination_payment_method` The PaymentMethod used as the payment instrument for an OutboundTransfer.\n  * `destination_payment_method_details` \n  * `expected_arrival_date` The date when funds are expected to arrive in the destination account.\n  * `financial_account` The FinancialAccount that funds were pulled from.\n  * `hosted_regulatory_receipt_url` A [hosted transaction receipt](https://stripe.com/docs/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `returned_details` Details about a returned OutboundTransfer. Only set when the status is `returned`.\n  * `statement_descriptor` Information about the OutboundTransfer to be sent to the recipient account.\n  * `status` Current status of the OutboundTransfer: `processing`, `failed`, `canceled`, `posted`, `returned`. An OutboundTransfer is `processing` if it has been created and is pending. The status changes to `posted` once the OutboundTransfer has been \"confirmed\" and funds have left the account, or to `failed` or `canceled`. If an OutboundTransfer fails to arrive at its destination, its status will change to `returned`.\n  * `status_transitions` \n  * `tracking_details` Details about network-specific tracking information if available.\n  * `transaction` The Transaction associated with this object.\n"
    @type t :: %__MODULE__{
            amount: integer,
            cancelable: boolean,
            created: integer,
            currency: binary,
            description: binary | nil,
            destination_payment_method: binary | nil,
            destination_payment_method_details: term,
            expected_arrival_date: integer,
            financial_account: binary,
            hosted_regulatory_receipt_url: binary | nil,
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
            returned_details: term | nil,
            statement_descriptor: binary,
            status: binary,
            status_transitions: term,
            tracking_details: term | nil,
            transaction: binary | Stripe.Treasury.Transaction.t()
          }
  )

  (
    @typedoc "ACH network tracking details."
    @type ach :: %{optional(:trace_id) => binary}
  )

  (
    @typedoc "Hash describing payment method configuration details."
    @type destination_payment_method_options :: %{
            optional(:us_bank_account) => us_bank_account | binary
          }
  )

  (
    @typedoc "Details about a returned OutboundTransfer."
    @type returned_details :: %{
            optional(:code) =>
              :account_closed
              | :account_frozen
              | :bank_account_restricted
              | :bank_ownership_changed
              | :declined
              | :incorrect_account_holder_name
              | :invalid_account_number
              | :invalid_currency
              | :no_account
              | :other
          }
  )

  (
    @typedoc "Details about network-specific tracking information."
    @type tracking_details :: %{
            optional(:ach) => ach,
            optional(:type) => :ach | :us_domestic_wire,
            optional(:us_domestic_wire) => us_domestic_wire
          }
  )

  (
    @typedoc nil
    @type us_bank_account :: %{optional(:network) => :ach | :us_domestic_wire}
  )

  (
    @typedoc "US domestic wire network tracking details."
    @type us_domestic_wire :: %{
            optional(:chips) => binary,
            optional(:imad) => binary,
            optional(:omad) => binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of OutboundTransfers sent from the specified FinancialAccount.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/outbound_transfers`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :canceled | :failed | :posted | :processing | :returned
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.OutboundTransfer.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/outbound_transfers", [], [])

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

    @doc "<p>Retrieves the details of an existing OutboundTransfer by passing the unique OutboundTransfer ID from either the OutboundTransfer creation request or OutboundTransfer list.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/outbound_transfers/{outbound_transfer}`\n"
    (
      @spec retrieve(
              outbound_transfer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(outbound_transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/outbound_transfers/{outbound_transfer}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "outbound_transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "outbound_transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [outbound_transfer]
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

    @doc "<p>Updates a test mode created OutboundTransfer with tracking details. The OutboundTransfer must not be cancelable, and cannot be in the <code>canceled</code> or <code>failed</code> states.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}`\n"
    (
      @spec update(
              outbound_transfer :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:tracking_details) => tracking_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(outbound_transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "outbound_transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "outbound_transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [outbound_transfer]
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

    @doc "<p>Transitions a test mode created OutboundTransfer to the <code>failed</code> status. The OutboundTransfer must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}/fail`\n"
    (
      @spec fail(
              outbound_transfer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def fail(outbound_transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}/fail",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "outbound_transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "outbound_transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [outbound_transfer]
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

    @doc "<p>Transitions a test mode created OutboundTransfer to the <code>posted</code> status. The OutboundTransfer must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}/post`\n"
    (
      @spec post(
              outbound_transfer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def post(outbound_transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}/post",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "outbound_transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "outbound_transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [outbound_transfer]
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

    @doc "<p>Transitions a test mode created OutboundTransfer to the <code>returned</code> status. The OutboundTransfer must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}/return`\n"
    (
      @spec return_outbound_transfer(
              outbound_transfer :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:returned_details) => returned_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def return_outbound_transfer(outbound_transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/outbound_transfers/{outbound_transfer}/return",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "outbound_transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "outbound_transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [outbound_transfer]
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

    @doc "<p>Creates an OutboundTransfer.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/outbound_transfers`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:description) => binary,
                optional(:destination_payment_method) => binary,
                optional(:destination_payment_method_options) =>
                  destination_payment_method_options,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:statement_descriptor) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/outbound_transfers", [], [])

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

    @doc "<p>An OutboundTransfer can be canceled if the funds have not yet been paid out.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/outbound_transfers/{outbound_transfer}/cancel`\n"
    (
      @spec cancel(
              outbound_transfer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundTransfer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def cancel(outbound_transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/outbound_transfers/{outbound_transfer}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "outbound_transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "outbound_transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [outbound_transfer]
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
