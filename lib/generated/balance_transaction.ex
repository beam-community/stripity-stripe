defmodule Stripe.BalanceTransaction do
  use Stripe.Entity

  @moduledoc "Balance transactions represent funds moving through your Stripe account.\nThey're created for every type of transaction that comes into or flows out of your Stripe account balance.\n\nRelated guide: [Balance transaction types](https://stripe.com/docs/reports/balance-transaction-types)"
  (
    defstruct [
      :amount,
      :available_on,
      :created,
      :currency,
      :description,
      :exchange_rate,
      :fee,
      :fee_details,
      :id,
      :net,
      :object,
      :reporting_category,
      :source,
      :status,
      :type
    ]

    @typedoc "The `balance_transaction` type.\n\n  * `amount` Gross amount of the transaction, in cents (or local equivalent).\n  * `available_on` The date the transaction's net funds will become available in the Stripe balance.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `exchange_rate` The exchange rate used, if applicable, for this transaction. Specifically, if money was converted from currency A to currency B, then the `amount` in currency A, times `exchange_rate`, would be the `amount` in currency B. For example, suppose you charged a customer 10.00 EUR. Then the PaymentIntent's `amount` would be `1000` and `currency` would be `eur`. Suppose this was converted into 12.34 USD in your Stripe account. Then the BalanceTransaction's `amount` would be `1234`, `currency` would be `usd`, and `exchange_rate` would be `1.234`.\n  * `fee` Fees (in cents (or local equivalent)) paid for this transaction.\n  * `fee_details` Detailed breakdown of fees (in cents (or local equivalent)) paid for this transaction.\n  * `id` Unique identifier for the object.\n  * `net` Net amount of the transaction, in cents (or local equivalent).\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `reporting_category` [Learn more](https://stripe.com/docs/reports/reporting-categories) about how reporting categories can help you understand balance transactions from an accounting perspective.\n  * `source` The Stripe object to which this transaction is related.\n  * `status` If the transaction's net funds are available in the Stripe balance yet. Either `available` or `pending`.\n  * `type` Transaction type: `adjustment`, `advance`, `advance_funding`, `anticipation_repayment`, `application_fee`, `application_fee_refund`, `charge`, `connect_collection_transfer`, `contribution`, `issuing_authorization_hold`, `issuing_authorization_release`, `issuing_dispute`, `issuing_transaction`, `payment`, `payment_failure_refund`, `payment_refund`, `payment_reversal`, `payout`, `payout_cancel`, `payout_failure`, `refund`, `refund_failure`, `reserve_transaction`, `reserved_funds`, `stripe_fee`, `stripe_fx_fee`, `tax_fee`, `topup`, `topup_reversal`, `transfer`, `transfer_cancel`, `transfer_failure`, or `transfer_refund`. [Learn more](https://stripe.com/docs/reports/balance-transaction-types) about balance transaction types and what they represent. If you are looking to classify transactions for accounting purposes, you might want to consider `reporting_category` instead.\n"
    @type t :: %__MODULE__{
            amount: integer,
            available_on: integer,
            created: integer,
            currency: binary,
            description: binary | nil,
            exchange_rate: term | nil,
            fee: integer,
            fee_details: term,
            id: binary,
            net: integer,
            object: binary,
            reporting_category: binary,
            source: (binary | term) | nil,
            status: binary,
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
    nil

    @doc "<p>Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). The transactions are returned in sorted order, with the most recent transactions appearing first.</p>\n\n<p>Note that this endpoint was previously called “Balance history” and used the path <code>/v1/balance/history</code>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/balance_transactions`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:currency) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:payout) => binary,
                optional(:source) => binary,
                optional(:starting_after) => binary,
                optional(:type) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.BalanceTransaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/balance_transactions", [], [])

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

    @doc "<p>Retrieves the balance transaction with the given ID.</p>\n\n<p>Note that this endpoint previously used the path <code>/v1/balance/history/:id</code>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/balance_transactions/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.BalanceTransaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/balance_transactions/{id}",
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
