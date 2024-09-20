defmodule Stripe.CustomerCashBalanceTransaction do
  use Stripe.Entity

  @moduledoc "Customers with certain payments enabled have a cash balance, representing funds that were paid\nby the customer to a merchant, but have not yet been allocated to a payment. Cash Balance Transactions\nrepresent when funds are moved into or out of this balance. This includes funding by the customer, allocation\nto payments, and refunds to the customer."
  (
    defstruct [
      :adjusted_for_overdraft,
      :applied_to_payment,
      :created,
      :currency,
      :customer,
      :ending_balance,
      :funded,
      :id,
      :livemode,
      :net_amount,
      :object,
      :refunded_from_payment,
      :transferred_to_balance,
      :type,
      :unapplied_from_payment
    ]

    @typedoc "The `customer_cash_balance_transaction` type.\n\n  * `adjusted_for_overdraft` \n  * `applied_to_payment` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` The customer whose available cash balance changed as a result of this transaction.\n  * `ending_balance` The total available cash balance for the specified currency after this transaction was applied. Represented in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `funded` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `net_amount` The amount by which the cash balance changed, represented in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). A positive value represents funds being added to the cash balance, a negative value represents funds being removed from the cash balance.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `refunded_from_payment` \n  * `transferred_to_balance` \n  * `type` The type of the cash balance transaction. New types may be added in future. See [Customer Balance](https://stripe.com/docs/payments/customer-balance#types) to learn more about these types.\n  * `unapplied_from_payment` \n"
    @type t :: %__MODULE__{
            adjusted_for_overdraft: term,
            applied_to_payment: term,
            created: integer,
            currency: binary,
            customer: binary | Stripe.Customer.t(),
            ending_balance: integer,
            funded: term,
            id: binary,
            livemode: boolean,
            net_amount: integer,
            object: binary,
            refunded_from_payment: term,
            transferred_to_balance: term,
            type: binary,
            unapplied_from_payment: term
          }
  )

  (
    nil

    @doc "<p>Returns a list of transactions that modified the customer’s <a href=\"/docs/payments/customer-balance\">cash balance</a>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/cash_balance_transactions`\n"
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
              {:ok, Stripe.List.t(Stripe.CustomerCashBalanceTransaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/cash_balance_transactions",
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

    @doc "<p>Retrieves a specific cash balance transaction, which updated the customer’s <a href=\"/docs/payments/customer-balance\">cash balance</a>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/cash_balance_transactions/{transaction}`\n"
    (
      @spec retrieve(
              customer :: binary(),
              transaction :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.CustomerCashBalanceTransaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(customer, transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/cash_balance_transactions/{transaction}",
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
end