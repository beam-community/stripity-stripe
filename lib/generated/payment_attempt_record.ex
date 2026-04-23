# credo:disable-for-this-file
defmodule Stripe.PaymentAttemptRecord do
  use Stripe.Entity

  @moduledoc "A Payment Attempt Record represents an individual attempt at making a payment, on or off Stripe.\nEach payment attempt tries to collect a fixed amount of money from a fixed customer and payment\nmethod. Payment Attempt Records are attached to Payment Records. Only one attempt per Payment Record\ncan have guaranteed funds."
  (
    defstruct [
      :amount,
      :amount_authorized,
      :amount_canceled,
      :amount_failed,
      :amount_guaranteed,
      :amount_refunded,
      :amount_requested,
      :application,
      :created,
      :customer_details,
      :customer_presence,
      :description,
      :id,
      :livemode,
      :metadata,
      :object,
      :payment_method_details,
      :payment_record,
      :processor_details,
      :reported_by,
      :shipping_details
    ]

    @typedoc "The `payment_attempt_record` type.\n\n  * `amount` \n  * `amount_authorized` \n  * `amount_canceled` \n  * `amount_failed` \n  * `amount_guaranteed` \n  * `amount_refunded` \n  * `amount_requested` \n  * `application` ID of the Connect application that created the PaymentAttemptRecord.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer_details` Customer information for this payment.\n  * `customer_presence` Indicates whether the customer was present in your checkout flow during this payment.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_method_details` Information about the Payment Method debited for this payment.\n  * `payment_record` ID of the Payment Record this Payment Attempt Record belongs to.\n  * `processor_details` \n  * `reported_by` Indicates who reported the payment.\n  * `shipping_details` Shipping information for this payment.\n"
    @type t :: %__MODULE__{
            amount: term,
            amount_authorized: term,
            amount_canceled: term,
            amount_failed: term,
            amount_guaranteed: term,
            amount_refunded: term,
            amount_requested: term,
            application: binary | nil,
            created: integer,
            customer_details: term | nil,
            customer_presence: binary | nil,
            description: binary | nil,
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
            payment_method_details: term | nil,
            payment_record: binary | nil,
            processor_details: term,
            reported_by: binary,
            shipping_details: term | nil
          }
  )

  (
    nil

    @doc "<p>List all the Payment Attempt Records attached to the specified Payment Record.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_attempt_records`\n"
    (
      @spec list(
              params :: %{
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:payment_record) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PaymentAttemptRecord.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payment_attempt_records", [], [])

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

    @doc "<p>Retrieves a Payment Attempt Record with the given ID</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_attempt_records/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentAttemptRecord.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_attempt_records/{id}",
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
