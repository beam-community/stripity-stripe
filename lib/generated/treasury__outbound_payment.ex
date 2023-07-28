defmodule Stripe.Treasury.OutboundPayment do
  use Stripe.Entity

  @moduledoc "Use OutboundPayments to send funds to another party's external bank account or [FinancialAccount](https://stripe.com/docs/api#financial_accounts). To send money to an account belonging to the same user, use an [OutboundTransfer](https://stripe.com/docs/api#outbound_transfers).\n\nSimulate OutboundPayment state changes with the `/v1/test_helpers/treasury/outbound_payments` endpoints. These methods can only be called on test mode objects."
  (
    defstruct [
      :amount,
      :cancelable,
      :created,
      :currency,
      :customer,
      :description,
      :destination_payment_method,
      :destination_payment_method_details,
      :end_user_details,
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
      :transaction
    ]

    @typedoc "The `treasury.outbound_payment` type.\n\n  * `amount` Amount (in cents) transferred.\n  * `cancelable` Returns `true` if the object can be canceled, and `false` otherwise.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` ID of the [customer](https://stripe.com/docs/api/customers) to whom an OutboundPayment is sent.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `destination_payment_method` The PaymentMethod via which an OutboundPayment is sent. This field can be empty if the OutboundPayment was created using `destination_payment_method_data`.\n  * `destination_payment_method_details` Details about the PaymentMethod for an OutboundPayment.\n  * `end_user_details` Details about the end user.\n  * `expected_arrival_date` The date when funds are expected to arrive in the destination account.\n  * `financial_account` The FinancialAccount that funds were pulled from.\n  * `hosted_regulatory_receipt_url` A [hosted transaction receipt](https://stripe.com/docs/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `returned_details` Details about a returned OutboundPayment. Only set when the status is `returned`.\n  * `statement_descriptor` The description that appears on the receiving end for an OutboundPayment (for example, bank statement for external bank transfer).\n  * `status` Current status of the OutboundPayment: `processing`, `failed`, `posted`, `returned`, `canceled`. An OutboundPayment is `processing` if it has been created and is pending. The status changes to `posted` once the OutboundPayment has been \"confirmed\" and funds have left the account, or to `failed` or `canceled`. If an OutboundPayment fails to arrive at its destination, its status will change to `returned`.\n  * `status_transitions` \n  * `transaction` The Transaction associated with this object.\n"
    @type t :: %__MODULE__{
            amount: integer,
            cancelable: boolean,
            created: integer,
            currency: binary,
            customer: binary | nil,
            description: binary | nil,
            destination_payment_method: binary | nil,
            destination_payment_method_details: term | nil,
            end_user_details: term | nil,
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
            transaction: binary | Stripe.Treasury.Transaction.t()
          }
  )

  (
    @typedoc nil
    @type address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    @typedoc "Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods."
    @type billing_details :: %{
            optional(:address) => address | binary,
            optional(:email) => binary | binary,
            optional(:name) => binary,
            optional(:phone) => binary
          }
  )

  (
    @typedoc "Hash used to generate the PaymentMethod to be used for this OutboundPayment. Exclusive with `destination_payment_method`."
    @type destination_payment_method_data :: %{
            optional(:billing_details) => billing_details,
            optional(:financial_account) => binary,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:type) => :financial_account | :us_bank_account,
            optional(:us_bank_account) => us_bank_account
          }
  )

  (
    @typedoc "Payment method-specific configuration for this OutboundPayment."
    @type destination_payment_method_options :: %{
            optional(:us_bank_account) => us_bank_account | binary
          }
  )

  (
    @typedoc "End user details."
    @type end_user_details :: %{optional(:ip_address) => binary, optional(:present) => boolean}
  )

  (
    @typedoc "Optional hash to set the the return code."
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
    @typedoc nil
    @type us_bank_account :: %{optional(:network) => :ach | :us_domestic_wire}
  )

  (
    nil

    @doc "<p>Creates an OutboundPayment.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/outbound_payments`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:customer) => binary,
                optional(:description) => binary,
                optional(:destination_payment_method) => binary,
                optional(:destination_payment_method_data) => destination_payment_method_data,
                optional(:destination_payment_method_options) =>
                  destination_payment_method_options,
                optional(:end_user_details) => end_user_details,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:statement_descriptor) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundPayment.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/outbound_payments", [], [])

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

    @doc "<p>Retrieves the details of an existing OutboundPayment by passing the unique OutboundPayment ID from either the OutboundPayment creation request or OutboundPayment list.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/outbound_payments/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundPayment.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/outbound_payments/{id}",
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

    @doc "<p>Returns a list of OutboundPayments sent from the specified FinancialAccount.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/outbound_payments`\n"
    (
      @spec list(
              params :: %{
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :canceled | :failed | :posted | :processing | :returned
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.OutboundPayment.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/outbound_payments", [], [])

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

    @doc "<p>Cancel an OutboundPayment.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/outbound_payments/{id}/cancel`\n"
    (
      @spec cancel(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundPayment.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def cancel(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/outbound_payments/{id}/cancel",
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

    @doc "<p>Transitions a test mode created OutboundPayment to the <code>failed</code> status. The OutboundPayment must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/outbound_payments/{id}/fail`\n"
    (
      @spec fail(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundPayment.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def fail(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/outbound_payments/{id}/fail",
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

    @doc "<p>Transitions a test mode created OutboundPayment to the <code>posted</code> status. The OutboundPayment must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/outbound_payments/{id}/post`\n"
    (
      @spec post(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundPayment.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def post(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/outbound_payments/{id}/post",
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

    @doc "<p>Transitions a test mode created OutboundPayment to the <code>returned</code> status. The OutboundPayment must already be in the <code>processing</code> state.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/outbound_payments/{id}/return`\n"
    (
      @spec return_outbound_payment(
              id :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:returned_details) => returned_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.OutboundPayment.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def return_outbound_payment(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/outbound_payments/{id}/return",
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