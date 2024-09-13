defmodule Stripe.Payout do
  use Stripe.Entity

  @moduledoc "A `Payout` object is created when you receive funds from Stripe, or when you\ninitiate a payout to either a bank account or debit card of a [connected\nStripe account](/docs/connect/bank-debit-card-payouts). You can retrieve individual payouts,\nand list all payouts. Payouts are made on [varying\nschedules](/docs/connect/manage-payout-schedule), depending on your country and\nindustry.\n\nRelated guide: [Receiving payouts](https://stripe.com/docs/payouts)"
  (
    defstruct [
      :amount,
      :application_fee,
      :application_fee_amount,
      :arrival_date,
      :automatic,
      :balance_transaction,
      :created,
      :currency,
      :description,
      :destination,
      :failure_balance_transaction,
      :failure_code,
      :failure_message,
      :id,
      :livemode,
      :metadata,
      :method,
      :object,
      :original_payout,
      :reconciliation_status,
      :reversed_by,
      :source_type,
      :statement_descriptor,
      :status,
      :type
    ]

    @typedoc "The `payout` type.\n\n  * `amount` The amount (in cents (or local equivalent)) that transfers to your bank account or debit card.\n  * `application_fee` The application fee (if any) for the payout. [See the Connect documentation](https://stripe.com/docs/connect/instant-payouts#monetization-and-fees) for details.\n  * `application_fee_amount` The amount of the application fee (if any) requested for the payout. [See the Connect documentation](https://stripe.com/docs/connect/instant-payouts#monetization-and-fees) for details.\n  * `arrival_date` Date that you can expect the payout to arrive in the bank. This factors in delays to account for weekends or bank holidays.\n  * `automatic` Returns `true` if the payout is created by an [automated payout schedule](https://stripe.com/docs/payouts#payout-schedule) and `false` if it's [requested manually](https://stripe.com/docs/payouts#manual-payouts).\n  * `balance_transaction` ID of the balance transaction that describes the impact of this payout on your account balance.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `destination` ID of the bank account or card the payout is sent to.\n  * `failure_balance_transaction` If the payout fails or cancels, this is the ID of the balance transaction that reverses the initial balance transaction and returns the funds from the failed payout back in your balance.\n  * `failure_code` Error code that provides a reason for a payout failure, if available. View our [list of failure codes](https://stripe.com/docs/api#payout_failures).\n  * `failure_message` Message that provides the reason for a payout failure, if available.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `method` The method used to send this payout, which can be `standard` or `instant`. `instant` is supported for payouts to debit cards and bank accounts in certain countries. Learn more about [bank support for Instant Payouts](https://stripe.com/docs/payouts/instant-payouts-banks).\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `original_payout` If the payout reverses another, this is the ID of the original payout.\n  * `reconciliation_status` If `completed`, you can use the [Balance Transactions API](https://stripe.com/docs/api/balance_transactions/list#balance_transaction_list-payout) to list all balance transactions that are paid out in this payout.\n  * `reversed_by` If the payout reverses, this is the ID of the payout that reverses this payout.\n  * `source_type` The source balance this payout came from, which can be one of the following: `card`, `fpx`, or `bank_account`.\n  * `statement_descriptor` Extra information about a payout that displays on the user's bank statement.\n  * `status` Current status of the payout: `paid`, `pending`, `in_transit`, `canceled` or `failed`. A payout is `pending` until it's submitted to the bank, when it becomes `in_transit`. The status changes to `paid` if the transaction succeeds, or to `failed` or `canceled` (within 5 business days). Some payouts that fail might initially show as `paid`, then change to `failed`.\n  * `type` Can be `bank_account` or `card`.\n"
    @type t :: %__MODULE__{
            amount: integer,
            application_fee: (binary | Stripe.ApplicationFee.t()) | nil,
            application_fee_amount: integer | nil,
            arrival_date: integer,
            automatic: boolean,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            created: integer,
            currency: binary,
            description: binary | nil,
            destination:
              (binary | Stripe.ExternalAccount.t() | Stripe.DeletedExternalAccount.t()) | nil,
            failure_balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            failure_code: binary | nil,
            failure_message: binary | nil,
            id: binary,
            livemode: boolean,
            metadata: term | nil,
            method: binary,
            object: binary,
            original_payout: (binary | Stripe.Payout.t()) | nil,
            reconciliation_status: binary,
            reversed_by: (binary | Stripe.Payout.t()) | nil,
            source_type: binary,
            statement_descriptor: binary | nil,
            status: binary,
            type: binary
          }
  )

  (
    @typedoc nil
    @type arrival_date :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
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
    nil

    @doc "<p>Returns a list of existing payouts sent to third-party bank accounts or payouts that Stripe sent to you. The payouts return in sorted order, with the most recently created payouts appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payouts`\n"
    (
      @spec list(
              params :: %{
                optional(:arrival_date) => arrival_date | integer,
                optional(:created) => created | integer,
                optional(:destination) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Payout.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payouts", [], [])

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

    @doc "<p>Retrieves the details of an existing payout. Supply the unique payout ID from either a payout creation request or the payout list. Stripe returns the corresponding payout information.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payouts/{payout}`\n"
    (
      @spec retrieve(
              payout :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Payout.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(payout, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payouts/{payout}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payout",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payout",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payout]
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

    @doc "<p>To send funds to your own bank account, create a new payout object. Your <a href=\"#balance\">Stripe balance</a> must cover the payout amount. If it doesn’t, you receive an “Insufficient Funds” error.</p>\n\n<p>If your API key is in test mode, money won’t actually be sent, though every other action occurs as if you’re in live mode.</p>\n\n<p>If you create a manual payout on a Stripe account that uses multiple payment source types, you need to specify the source type balance that the payout draws from. The <a href=\"#balance_object\">balance object</a> details available and pending amounts by source type.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:description) => binary,
                optional(:destination) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:method) => :instant | :standard,
                optional(:source_type) => :bank_account | :card | :fpx,
                optional(:statement_descriptor) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Payout.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payouts", [], [])

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

    @doc "<p>Updates the specified payout by setting the values of the parameters you pass. We don’t change parameters that you don’t provide. This request only accepts the metadata as arguments.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts/{payout}`\n"
    (
      @spec update(
              payout :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Payout.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(payout, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payouts/{payout}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payout",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payout",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payout]
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

    @doc "<p>You can cancel a previously created payout if its status is <code>pending</code>. Stripe refunds the funds to your available balance. You can’t cancel automatic Stripe payouts.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts/{payout}/cancel`\n"
    (
      @spec cancel(
              payout :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Payout.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def cancel(payout, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payouts/{payout}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payout",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payout",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payout]
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

    @doc "<p>Reverses a payout by debiting the destination bank account. At this time, you can only reverse payouts for connected accounts to US bank accounts. If the payout is manual and in the <code>pending</code> status, use <code>/v1/payouts/:id/cancel</code> instead.</p>\n\n<p>By requesting a reversal through <code>/v1/payouts/:id/reverse</code>, you confirm that the authorized signatory of the selected bank account authorizes the debit on the bank account and that no other authorization is required.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts/{payout}/reverse`\n"
    (
      @spec reverse(
              payout :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Payout.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def reverse(payout, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payouts/{payout}/reverse",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payout",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payout",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payout]
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