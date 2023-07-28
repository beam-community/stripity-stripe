defmodule Stripe.CustomerBalanceTransaction do
  use Stripe.Entity

  @moduledoc "Each customer has a [Balance](https://stripe.com/docs/api/customers/object#customer_object-balance) value,\nwhich denotes a debit or credit that's automatically applied to their next invoice upon finalization.\nYou may modify the value directly by using the [update customer API](https://stripe.com/docs/api/customers/update),\nor by creating a Customer Balance Transaction, which increments or decrements the customer's `balance` by the specified `amount`.\n\nRelated guide: [Customer balance](https://stripe.com/docs/billing/customer/balance)"
  (
    defstruct [
      :amount,
      :created,
      :credit_note,
      :currency,
      :customer,
      :description,
      :ending_balance,
      :id,
      :invoice,
      :livemode,
      :metadata,
      :object,
      :type
    ]

    @typedoc "The `customer_balance_transaction` type.\n\n  * `amount` The amount of the transaction. A negative value is a credit for the customer's balance, and a positive value is a debit to the customer's `balance`.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `credit_note` The ID of the credit note (if any) related to the transaction.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` The ID of the customer the transaction belongs to.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `ending_balance` The customer's `balance` after the transaction was applied. A negative value decreases the amount due on the customer's next invoice. A positive value increases the amount due on the customer's next invoice.\n  * `id` Unique identifier for the object.\n  * `invoice` The ID of the invoice (if any) related to the transaction.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `type` Transaction type: `adjustment`, `applied_to_invoice`, `credit_note`, `initial`, `invoice_overpaid`, `invoice_too_large`, `invoice_too_small`, `unspent_receiver_credit`, or `unapplied_from_invoice`. See the [Customer Balance page](https://stripe.com/docs/billing/customer/balance#types) to learn more about transaction types.\n"
    @type t :: %__MODULE__{
            amount: integer,
            created: integer,
            credit_note: (binary | Stripe.CreditNote.t()) | nil,
            currency: binary,
            customer: binary | Stripe.Customer.t(),
            description: binary | nil,
            ending_balance: integer,
            id: binary,
            invoice: (binary | Stripe.Invoice.t()) | nil,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            type: binary
          }
  )

  (
    nil

    @doc "<p>Retrieves a specific customer balance transaction that updated the customer’s <a href=\"/docs/billing/customer/balance\">balances</a>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/balance_transactions/{transaction}`\n"
    (
      @spec retrieve(
              customer :: binary(),
              transaction :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.CustomerBalanceTransaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(customer, transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/balance_transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
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
            [customer, transaction]
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

    @doc "<p>Returns a list of transactions that updated the customer’s <a href=\"/docs/billing/customer/balance\">balances</a>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/balance_transactions`\n"
    (
      @spec list(
              customer :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.CustomerBalanceTransaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/balance_transactions",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Creates an immutable transaction that updates the customer’s credit <a href=\"/docs/billing/customer/balance\">balance</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers/{customer}/balance_transactions`\n"
    (
      @spec create(
              customer :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.CustomerBalanceTransaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/balance_transactions",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Most credit balance transaction fields are immutable, but you may update its <code>description</code> and <code>metadata</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers/{customer}/balance_transactions/{transaction}`\n"
    (
      @spec update(
              customer :: binary(),
              transaction :: binary(),
              params :: %{
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.CustomerBalanceTransaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(customer, transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/balance_transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
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
            [customer, transaction]
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