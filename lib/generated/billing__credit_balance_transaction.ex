# credo:disable-for-this-file
defmodule Stripe.Billing.CreditBalanceTransaction do
  use Stripe.Entity

  @moduledoc "A credit balance transaction is a resource representing a transaction (either a credit or a debit) against an existing credit grant."
  (
    defstruct [
      :created,
      :credit,
      :credit_grant,
      :debit,
      :effective_at,
      :id,
      :livemode,
      :object,
      :test_clock,
      :type
    ]

    @typedoc "The `billing.credit_balance_transaction` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `credit` Credit details for this credit balance transaction. Only present if type is `credit`.\n  * `credit_grant` The credit grant associated with this credit balance transaction.\n  * `debit` Debit details for this credit balance transaction. Only present if type is `debit`.\n  * `effective_at` The effective time of this credit balance transaction.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `test_clock` ID of the test clock this credit balance transaction belongs to.\n  * `type` The type of credit balance transaction (credit or debit).\n"
    @type t :: %__MODULE__{
            created: integer,
            credit: term | nil,
            credit_grant: binary | Stripe.Billing.CreditGrant.t(),
            debit: term | nil,
            effective_at: integer,
            id: binary,
            livemode: boolean,
            object: binary,
            test_clock: (binary | Stripe.TestHelpers.TestClock.t()) | nil,
            type: binary | nil
          }
  )

  (
    nil

    @doc "<p>Retrieve a list of credit balance transactions.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/credit_balance_transactions`\n"
    (
      @spec list(
              params :: %{
                optional(:credit_grant) => binary,
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Billing.CreditBalanceTransaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/credit_balance_transactions",
            [],
            []
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

    @doc "<p>Retrieves a credit balance transaction.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/credit_balance_transactions/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.CreditBalanceTransaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/credit_balance_transactions/{id}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "id",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "id",
                  properties: [],
                  title: nil,
                  type: "string"
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