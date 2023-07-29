defmodule Stripe.Balance do
  use Stripe.Entity

  @moduledoc "This is an object representing your Stripe balance. You can retrieve it to see\nthe balance currently on your Stripe account.\n\nYou can also retrieve the balance history, which contains a list of\n[transactions](https://stripe.com/docs/reporting/balance-transaction-types) that contributed to the balance\n(charges, payouts, and so forth).\n\nThe available and pending amounts for each currency are broken down further by\npayment source types.\n\nRelated guide: [Understanding Connect account balances](https://stripe.com/docs/connect/account-balances)"
  (
    defstruct [
      :available,
      :connect_reserved,
      :instant_available,
      :issuing,
      :livemode,
      :object,
      :pending
    ]

    @typedoc "The `balance` type.\n\n  * `available` Funds that are available to be transferred or paid out, whether automatically by Stripe or explicitly via the [Transfers API](https://stripe.com/docs/api#transfers) or [Payouts API](https://stripe.com/docs/api#payouts). The available balance for each currency and payment type can be found in the `source_types` property.\n  * `connect_reserved` Funds held due to negative balances on connected Custom accounts. The connect reserve balance for each currency and payment type can be found in the `source_types` property.\n  * `instant_available` Funds that can be paid out using Instant Payouts.\n  * `issuing` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `pending` Funds that are not yet available in the balance. The pending balance for each currency, and for each payment type, can be found in the `source_types` property.\n"
    @type t :: %__MODULE__{
            available: term,
            connect_reserved: term,
            instant_available: term,
            issuing: term,
            livemode: boolean,
            object: binary,
            pending: term
          }
  )

  (
    nil

    @doc "<p>Retrieves the current account balance, based on the authentication that was used to make the request.\n For a sample request, see <a href=\"/docs/connect/account-balances#accounting-for-negative-balances\">Accounting for negative balances</a>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/balance`\n"
    (
      @spec retrieve(params :: %{optional(:expand) => list(binary)}, opts :: Keyword.t()) ::
              {:ok, Stripe.Balance.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/balance", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
