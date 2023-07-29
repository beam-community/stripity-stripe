defmodule Stripe.Radar.EarlyFraudWarning do
  use Stripe.Entity

  @moduledoc "An early fraud warning indicates that the card issuer has notified us that a\ncharge may be fraudulent.\n\nRelated guide: [Early fraud warnings](https://stripe.com/docs/disputes/measuring#early-fraud-warnings)"
  (
    defstruct [
      :actionable,
      :charge,
      :created,
      :fraud_type,
      :id,
      :livemode,
      :object,
      :payment_intent
    ]

    @typedoc "The `radar.early_fraud_warning` type.\n\n  * `actionable` An EFW is actionable if it has not received a dispute and has not been fully refunded. You may wish to proactively refund a charge that receives an EFW, in order to avoid receiving a dispute later.\n  * `charge` ID of the charge this early fraud warning is for, optionally expanded.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `fraud_type` The type of fraud labelled by the issuer. One of `card_never_received`, `fraudulent_card_application`, `made_with_counterfeit_card`, `made_with_lost_card`, `made_with_stolen_card`, `misc`, `unauthorized_use_of_card`.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_intent` ID of the Payment Intent this early fraud warning is for, optionally expanded.\n"
    @type t :: %__MODULE__{
            actionable: boolean,
            charge: binary | Stripe.Charge.t(),
            created: integer,
            fraud_type: binary,
            id: binary,
            livemode: boolean,
            object: binary,
            payment_intent: binary | Stripe.PaymentIntent.t()
          }
  )

  (
    nil

    @doc "<p>Returns a list of early fraud warnings.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/radar/early_fraud_warnings`\n"
    (
      @spec list(
              params :: %{
                optional(:charge) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:payment_intent) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Radar.EarlyFraudWarning.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/radar/early_fraud_warnings", [], [])

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

    @doc "<p>Retrieves the details of an early fraud warning that has previously been created. </p>\n\n<p>Please refer to the <a href=\"#early_fraud_warning_object\">early fraud warning</a> object reference for more details.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/radar/early_fraud_warnings/{early_fraud_warning}`\n"
    (
      @spec retrieve(
              early_fraud_warning :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Radar.EarlyFraudWarning.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(early_fraud_warning, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/radar/early_fraud_warnings/{early_fraud_warning}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "early_fraud_warning",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "early_fraud_warning",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [early_fraud_warning]
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
