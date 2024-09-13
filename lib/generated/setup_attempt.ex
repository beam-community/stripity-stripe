defmodule Stripe.SetupAttempt do
  use Stripe.Entity

  @moduledoc "A SetupAttempt describes one attempted confirmation of a SetupIntent,\nwhether that confirmation is successful or unsuccessful. You can use\nSetupAttempts to inspect details of a specific attempt at setting up a\npayment method using a SetupIntent."
  (
    defstruct [
      :application,
      :attach_to_self,
      :created,
      :customer,
      :flow_directions,
      :id,
      :livemode,
      :object,
      :on_behalf_of,
      :payment_method,
      :payment_method_details,
      :setup_error,
      :setup_intent,
      :status,
      :usage
    ]

    @typedoc "The `setup_attempt` type.\n\n  * `application` The value of [application](https://stripe.com/docs/api/setup_intents/object#setup_intent_object-application) on the SetupIntent at the time of this confirmation.\n  * `attach_to_self` If present, the SetupIntent's payment method will be attached to the in-context Stripe Account.\n\nIt can only be used for this Stripe Account’s own money movement flows like InboundTransfer and OutboundTransfers. It cannot be set to true when setting up a PaymentMethod for a Customer, and defaults to false when attaching a PaymentMethod to a Customer.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` The value of [customer](https://stripe.com/docs/api/setup_intents/object#setup_intent_object-customer) on the SetupIntent at the time of this confirmation.\n  * `flow_directions` Indicates the directions of money movement for which this payment method is intended to be used.\n\nInclude `inbound` if you intend to use the payment method as the origin to pull funds from. Include `outbound` if you intend to use the payment method as the destination to send funds to. You can include both if you intend to use the payment method for both purposes.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `on_behalf_of` The value of [on_behalf_of](https://stripe.com/docs/api/setup_intents/object#setup_intent_object-on_behalf_of) on the SetupIntent at the time of this confirmation.\n  * `payment_method` ID of the payment method used with this SetupAttempt.\n  * `payment_method_details` \n  * `setup_error` The error encountered during this attempt to confirm the SetupIntent, if any.\n  * `setup_intent` ID of the SetupIntent that this attempt belongs to.\n  * `status` Status of this SetupAttempt, one of `requires_confirmation`, `requires_action`, `processing`, `succeeded`, `failed`, or `abandoned`.\n  * `usage` The value of [usage](https://stripe.com/docs/api/setup_intents/object#setup_intent_object-usage) on the SetupIntent at the time of this confirmation, one of `off_session` or `on_session`.\n"
    @type t :: %__MODULE__{
            application: (binary | term) | nil,
            attach_to_self: boolean,
            created: integer,
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            flow_directions: term | nil,
            id: binary,
            livemode: boolean,
            object: binary,
            on_behalf_of: (binary | Stripe.Account.t()) | nil,
            payment_method: binary | Stripe.PaymentMethod.t(),
            payment_method_details: term,
            setup_error: Stripe.ApiErrors.t() | nil,
            setup_intent: binary | Stripe.SetupIntent.t(),
            status: binary,
            usage: binary
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

    @doc "<p>Returns a list of SetupAttempts that associate with a provided SetupIntent.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/setup_attempts`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:setup_intent) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.SetupAttempt.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/setup_attempts", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end