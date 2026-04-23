defmodule Stripe.Billing.CreditBalanceSummary do
  use Stripe.Entity
  @moduledoc "Indicates the billing credit balance for billing credits granted to a customer."
  (
    defstruct [:balances, :customer, :livemode, :object]

    @typedoc "The `billing.credit_balance_summary` type.\n\n  * `balances` The billing credit balances. One entry per credit grant currency. If a customer only has credit grants in a single currency, then this will have a single balance entry.\n  * `customer` The customer the balance is for.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            balances: term,
            customer: binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t(),
            livemode: boolean,
            object: binary
          }
  )

  (
    @typedoc "The billing credit applicability scope for which to fetch credit balance summary."
    @type applicability_scope :: %{
            optional(:price_type) => :metered,
            optional(:prices) => list(prices)
          }
  )

  (
    @typedoc nil
    @type filter :: %{
            optional(:applicability_scope) => applicability_scope,
            optional(:credit_grant) => binary,
            optional(:type) => :applicability_scope | :credit_grant
          }
  )

  (
    @typedoc nil
    @type prices :: %{optional(:id) => binary}
  )

  (
    nil

    @doc "<p>Retrieves the credit balance summary for a customer.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/credit_balance_summary`\n"
    (
      @spec retrieve(
              params :: %{
                optional(:customer) => binary,
                optional(:expand) => list(binary),
                optional(:filter) => filter
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.CreditBalanceSummary.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/billing/credit_balance_summary", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end