# credo:disable-for-this-file
defmodule Stripe.BalanceSettings do
  use Stripe.Entity

  @moduledoc "Options for customizing account balances and payout settings for a Stripe platform’s connected accounts."
  (
    defstruct [:object, :payments]

    @typedoc "The `balance_settings` type.\n\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payments` \n"
    @type t :: %__MODULE__{object: binary, payments: term}
  )

  (
    @typedoc "Settings that apply to the [Payments Balance](https://docs.stripe.com/api/balance)."
    @type payments :: %{
            optional(:debit_negative_balances) => boolean,
            optional(:payouts) => payouts,
            optional(:settlement_timing) => settlement_timing
          }
  )

  (
    @typedoc "Settings specific to the account's payouts."
    @type payouts :: %{
            optional(:minimum_balance_by_currency) => map() | binary,
            optional(:schedule) => schedule,
            optional(:statement_descriptor) => binary
          }
  )

  (
    @typedoc "Details on when funds from charges are available, and when they are paid out to an external account. For details, see our [Setting Bank and Debit Card Payouts](/connect/bank-transfers#payout-information) documentation."
    @type schedule :: %{
            optional(:interval) => :daily | :manual | :monthly | :weekly,
            optional(:monthly_payout_days) => list(integer),
            optional(:weekly_payout_days) => list(:friday | :monday | :thursday | :tuesday | :wednesday)
          }
  )

  (
    @typedoc "Settings related to the account's balance settlement timing."
    @type settlement_timing :: %{optional(:delay_days_override) => integer | binary}
  )

  (
    nil

    @doc "<p>Retrieves balance settings for a given connected account.\n Related guide: <a href=\"/connect/authentication\">Making API calls for connected accounts</a></p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/balance_settings`\n"
    (
      @spec retrieve(params :: %{optional(:expand) => list(binary)}, opts :: Keyword.t()) ::
              {:ok, Stripe.BalanceSettings.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/balance_settings", [], [])

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

    @doc "<p>Updates balance settings for a given connected account.\n Related guide: <a href=\"/connect/authentication\">Making API calls for connected accounts</a></p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/balance_settings`\n"
    (
      @spec update(
              params :: %{optional(:expand) => list(binary), optional(:payments) => payments},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.BalanceSettings.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/balance_settings", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
