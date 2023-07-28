defmodule Stripe.Mandate do
  use Stripe.Entity

  @moduledoc "A Mandate is a record of the permission a customer has given you to debit their payment method."
  (
    defstruct [
      :customer_acceptance,
      :id,
      :livemode,
      :multi_use,
      :object,
      :on_behalf_of,
      :payment_method,
      :payment_method_details,
      :single_use,
      :status,
      :type
    ]

    @typedoc "The `mandate` type.\n\n  * `customer_acceptance` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `multi_use` \n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `on_behalf_of` The account (if any) for which the mandate is intended.\n  * `payment_method` ID of the payment method associated with this mandate.\n  * `payment_method_details` \n  * `single_use` \n  * `status` The status of the mandate, which indicates whether it can be used to initiate a payment.\n  * `type` The type of the mandate.\n"
    @type t :: %__MODULE__{
            customer_acceptance: term,
            id: binary,
            livemode: boolean,
            multi_use: term,
            object: binary,
            on_behalf_of: binary,
            payment_method: binary | Stripe.PaymentMethod.t(),
            payment_method_details: term,
            single_use: term,
            status: binary,
            type: binary
          }
  )

  (
    nil

    @doc "<p>Retrieves a Mandate object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/mandates/{mandate}`\n"
    (
      @spec retrieve(
              mandate :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Mandate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(mandate, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/mandates/{mandate}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "mandate",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "mandate",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [mandate]
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