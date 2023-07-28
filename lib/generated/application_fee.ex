defmodule Stripe.ApplicationFee do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :account,
      :amount,
      :amount_refunded,
      :application,
      :balance_transaction,
      :charge,
      :created,
      :currency,
      :id,
      :livemode,
      :object,
      :originating_transaction,
      :refunded,
      :refunds
    ]

    @typedoc "The `application_fee` type.\n\n  * `account` ID of the Stripe account this fee was taken from.\n  * `amount` Amount earned, in %s.\n  * `amount_refunded` Amount in %s refunded (can be less than the amount attribute on the fee if a partial refund was issued)\n  * `application` ID of the Connect application that earned the fee.\n  * `balance_transaction` Balance transaction that describes the impact of this collected application fee on your account balance (not including refunds).\n  * `charge` ID of the charge that the application fee was taken from.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `originating_transaction` ID of the corresponding charge on the platform account, if this fee was the result of a charge using the `destination` parameter.\n  * `refunded` Whether the fee has been fully refunded. If the fee is only partially refunded, this attribute will still be false.\n  * `refunds` A list of refunds that have been applied to the fee.\n"
    @type t :: %__MODULE__{
            account: binary | Stripe.Account.t(),
            amount: integer,
            amount_refunded: integer,
            application: binary | term,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            charge: binary | Stripe.Charge.t(),
            created: integer,
            currency: binary,
            id: binary,
            livemode: boolean,
            object: binary,
            originating_transaction: (binary | Stripe.Charge.t()) | nil,
            refunded: boolean,
            refunds: term
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

    @doc "<p>Returns a list of application fees you’ve previously collected. The application fees are returned in sorted order, with the most recent fees appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/application_fees`\n"
    (
      @spec list(
              params :: %{
                optional(:charge) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.ApplicationFee.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/application_fees", [], [])

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

    @doc "<p>Retrieves the details of an application fee that your account has collected. The same information is returned when refunding the application fee.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/application_fees/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ApplicationFee.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/application_fees/{id}",
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