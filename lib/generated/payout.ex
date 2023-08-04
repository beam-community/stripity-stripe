defmodule Stripe.Payout do
  use Stripe.Entity

  @moduledoc "A `Payout` object is created when you receive funds from Stripe, or when you\ninitiate a payout to either a bank account or debit card of a [connected\nStripe account](/docs/connect/bank-debit-card-payouts). You can retrieve individual payouts,\nas well as list all payouts. Payouts are made on [varying\nschedules](/docs/connect/manage-payout-schedule), depending on your country and\nindustry.\n\nRelated guide: [Receiving payouts](https://stripe.com/docs/payouts)"
  (
    defstruct [
      :amount,
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

    @typedoc "The `payout` type.\n\n  * `amount` Amount (in cents (or local equivalent)) to be transferred to your bank account or debit card.\n  * `arrival_date` Date the payout is expected to arrive in the bank. This factors in delays like weekends or bank holidays.\n  * `automatic` Returns `true` if the payout was created by an [automated payout schedule](https://stripe.com/docs/payouts#payout-schedule), and `false` if it was [requested manually](https://stripe.com/docs/payouts#manual-payouts).\n  * `balance_transaction` ID of the balance transaction that describes the impact of this payout on your account balance.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `destination` ID of the bank account or card the payout was sent to.\n  * `failure_balance_transaction` If the payout failed or was canceled, this will be the ID of the balance transaction that reversed the initial balance transaction, and puts the funds from the failed payout back in your balance.\n  * `failure_code` Error code explaining reason for payout failure if available. See [Types of payout failures](https://stripe.com/docs/api#payout_failures) for a list of failure codes.\n  * `failure_message` Message to user further explaining reason for payout failure if available.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `method` The method used to send this payout, which can be `standard` or `instant`. `instant` is only supported for payouts to debit cards. (See [Instant payouts for marketplaces](https://stripe.com/blog/instant-payouts-for-marketplaces) for more information.)\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `original_payout` If the payout reverses another, this is the ID of the original payout.\n  * `reconciliation_status` If `completed`, the [Balance Transactions API](https://stripe.com/docs/api/balance_transactions/list#balance_transaction_list-payout) may be used to list all Balance Transactions that were paid out in this payout.\n  * `reversed_by` If the payout was reversed, this is the ID of the payout that reverses this payout.\n  * `source_type` The source balance this payout came from. One of `card`, `fpx`, or `bank_account`.\n  * `statement_descriptor` Extra information about a payout to be displayed on the user's bank statement.\n  * `status` Current status of the payout: `paid`, `pending`, `in_transit`, `canceled` or `failed`. A payout is `pending` until it is submitted to the bank, when it becomes `in_transit`. The status then changes to `paid` if the transaction goes through, or to `failed` or `canceled` (within 5 business days). Some failed payouts may initially show as `paid` but then change to `failed`.\n  * `type` Can be `bank_account` or `card`.\n"
    @type t :: %__MODULE__{
            amount: integer,
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

    @doc "<p>Retrieves the details of an existing payout. Supply the unique payout ID from either a payout creation request or the payout list, and Stripe will return the corresponding payout information.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payouts/{payout}`\n"
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

    @doc "<p>Returns a list of existing payouts sent to third-party bank accounts or that Stripe has sent you. The payouts are returned in sorted order, with the most recently created payouts appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payouts`\n"
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

    @doc "<p>To send funds to your own bank account, you create a new payout object. Your <a href=\"#balance\">Stripe balance</a> must be able to cover the payout amount, or you’ll receive an “Insufficient Funds” error.</p>\n\n<p>If your API key is in test mode, money won’t actually be sent, though everything else will occur as if in live mode.</p>\n\n<p>If you are creating a manual payout on a Stripe account that uses multiple payment source types, you’ll need to specify the source type balance that the payout should draw from. The <a href=\"#balance_object\">balance object</a> details available and pending amounts by source type.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts`\n"
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

    @doc "<p>Updates the specified payout by setting the values of the parameters passed. Any parameters not provided will be left unchanged. This request accepts only the metadata as arguments.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts/{payout}`\n"
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

    @doc "<p>A previously created payout can be canceled if it has not yet been paid out. Funds will be refunded to your available balance. You may not cancel automatic Stripe payouts.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts/{payout}/cancel`\n"
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

    @doc "<p>Reverses a payout by debiting the destination bank account. Only payouts for connected accounts to US bank accounts may be reversed at this time. If the payout is in the <code>pending</code> status, <code>/v1/payouts/:id/cancel</code> should be used instead.</p>\n\n<p>By requesting a reversal via <code>/v1/payouts/:id/reverse</code>, you confirm that the authorized signatory of the selected bank account has authorized the debit on the bank account and that no other authorization is required.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payouts/{payout}/reverse`\n"
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
