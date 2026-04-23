# credo:disable-for-this-file
defmodule Stripe.Tax.Association do
  use Stripe.Entity

  @moduledoc "A Tax Association exposes the Tax Transactions that Stripe attempted to create on your behalf based on the PaymentIntent input"
  (
    defstruct [:calculation, :id, :object, :payment_intent, :tax_transaction_attempts]

    @typedoc "The `tax.association` type.\n\n  * `calculation` The [Tax Calculation](https://stripe.com/docs/api/tax/calculations/object) that was included in PaymentIntent.\n  * `id` Unique identifier for the object.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_intent` The [PaymentIntent](https://stripe.com/docs/api/payment_intents/object) that this Tax Association is tracking.\n  * `tax_transaction_attempts` Information about the tax transactions linked to this payment intent\n"
    @type t :: %__MODULE__{
            calculation: binary,
            id: binary,
            object: binary,
            payment_intent: binary,
            tax_transaction_attempts: term | nil
          }
  )

  (
    nil

    @doc "<p>Finds a tax association object by PaymentIntent id.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax/associations/find`\n"
    (
      @spec find(
              params :: %{optional(:expand) => list(binary), optional(:payment_intent) => binary},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Association.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def find(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax/associations/find", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
