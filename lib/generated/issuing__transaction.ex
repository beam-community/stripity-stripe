defmodule Stripe.Issuing.Transaction do
  use Stripe.Entity

  @moduledoc "Any use of an [issued card](https://stripe.com/docs/issuing) that results in funds entering or leaving\nyour Stripe account, such as a completed purchase or refund, is represented by an Issuing\n`Transaction` object.\n\nRelated guide: [Issued card transactions](https://stripe.com/docs/issuing/purchases/transactions)"
  (
    defstruct [
      :amount,
      :amount_details,
      :authorization,
      :balance_transaction,
      :card,
      :cardholder,
      :created,
      :currency,
      :dispute,
      :id,
      :livemode,
      :merchant_amount,
      :merchant_currency,
      :merchant_data,
      :metadata,
      :object,
      :purchase_details,
      :treasury,
      :type,
      :wallet
    ]

    @typedoc "The `issuing.transaction` type.\n\n  * `amount` The transaction amount, which will be reflected in your balance. This amount is in your currency and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `amount_details` Detailed breakdown of amount components. These amounts are denominated in `currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `authorization` The `Authorization` object that led to this transaction.\n  * `balance_transaction` ID of the [balance transaction](https://stripe.com/docs/api/balance_transactions) associated with this transaction.\n  * `card` The card used to make this transaction.\n  * `cardholder` The cardholder to whom this transaction belongs.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `dispute` If you've disputed the transaction, the ID of the dispute.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `merchant_amount` The amount that the merchant will receive, denominated in `merchant_currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). It will be different from `amount` if the merchant is taking payment in a different currency.\n  * `merchant_currency` The currency with which the merchant is taking payment.\n  * `merchant_data` \n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `purchase_details` Additional purchase information that is optionally provided by the merchant.\n  * `treasury` [Treasury](https://stripe.com/docs/api/treasury) details related to this transaction if it was created on a [FinancialAccount](/docs/api/treasury/financial_accounts\n  * `type` The nature of the transaction.\n  * `wallet` The digital wallet used for this transaction. One of `apple_pay`, `google_pay`, or `samsung_pay`.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_details: term | nil,
            authorization: (binary | Stripe.Issuing.Authorization.t()) | nil,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            card: binary | Stripe.Issuing.Card.t(),
            cardholder: (binary | Stripe.Issuing.Cardholder.t()) | nil,
            created: integer,
            currency: binary,
            dispute: (binary | Stripe.Issuing.Dispute.t()) | nil,
            id: binary,
            livemode: boolean,
            merchant_amount: integer,
            merchant_currency: binary,
            merchant_data: term,
            metadata: term,
            object: binary,
            purchase_details: term | nil,
            treasury: term | nil,
            type: binary,
            wallet: binary | nil
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

    @doc "<p>Returns a list of Issuing <code>Transaction</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/transactions`\n"
    (
      @spec list(
              params :: %{
                optional(:card) => binary,
                optional(:cardholder) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:type) => :capture | :refund
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.Transaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/transactions", [], [])

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

    @doc "<p>Retrieves an Issuing <code>Transaction</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/transactions/{transaction}`\n"
    (
      @spec retrieve(
              transaction :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
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

    @doc "<p>Updates the specified Issuing <code>Transaction</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/transactions/{transaction}`\n"
    (
      @spec update(
              transaction :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
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