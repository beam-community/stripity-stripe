defmodule Stripe.Treasury.ReceivedDebit do
  use Stripe.Entity

  @moduledoc "ReceivedDebits represent funds pulled from a [FinancialAccount](https://stripe.com/docs/api#financial_accounts). These are not initiated from the FinancialAccount."
  (
    defstruct [
      :amount,
      :created,
      :currency,
      :description,
      :failure_code,
      :financial_account,
      :hosted_regulatory_receipt_url,
      :id,
      :initiating_payment_method_details,
      :linked_flows,
      :livemode,
      :network,
      :object,
      :reversal_details,
      :status,
      :transaction
    ]

    @typedoc "The `treasury.received_debit` type.\n\n  * `amount` Amount (in cents) transferred.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `failure_code` Reason for the failure. A ReceivedDebit might fail because the FinancialAccount doesn't have sufficient funds, is closed, or is frozen.\n  * `financial_account` The FinancialAccount that funds were pulled from.\n  * `hosted_regulatory_receipt_url` A [hosted transaction receipt](https://stripe.com/docs/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.\n  * `id` Unique identifier for the object.\n  * `initiating_payment_method_details` \n  * `linked_flows` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `network` The network used for the ReceivedDebit.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `reversal_details` Details describing when a ReceivedDebit might be reversed.\n  * `status` Status of the ReceivedDebit. ReceivedDebits are created with a status of either `succeeded` (approved) or `failed` (declined). The failure reason can be found under the `failure_code`.\n  * `transaction` The Transaction associated with this object.\n"
    @type t :: %__MODULE__{
            amount: integer,
            created: integer,
            currency: binary,
            description: binary,
            failure_code: binary | nil,
            financial_account: binary | nil,
            hosted_regulatory_receipt_url: binary | nil,
            id: binary,
            initiating_payment_method_details: term,
            linked_flows: term,
            livemode: boolean,
            network: binary,
            object: binary,
            reversal_details: term | nil,
            status: binary,
            transaction: (binary | Stripe.Treasury.Transaction.t()) | nil
          }
  )

  (
    @typedoc "Initiating payment method details for the object."
    @type initiating_payment_method_details :: %{
            optional(:type) => :us_bank_account,
            optional(:us_bank_account) => us_bank_account
          }
  )

  (
    @typedoc "Optional fields for `us_bank_account`."
    @type us_bank_account :: %{
            optional(:account_holder_name) => binary,
            optional(:account_number) => binary,
            optional(:routing_number) => binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of ReceivedDebits.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/received_debits`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :failed | :succeeded
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.ReceivedDebit.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/received_debits", [], [])

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

    @doc "<p>Retrieves the details of an existing ReceivedDebit by passing the unique ReceivedDebit ID from the ReceivedDebit list</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/received_debits/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.ReceivedDebit.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/received_debits/{id}",
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

    @doc "<p>Use this endpoint to simulate a test mode ReceivedDebit initiated by a third party. In live mode, you can’t directly create ReceivedDebits initiated by third parties.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/treasury/received_debits`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:financial_account) => binary,
                optional(:initiating_payment_method_details) => initiating_payment_method_details,
                optional(:network) => :ach
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.ReceivedDebit.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/treasury/received_debits",
            [],
            []
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
