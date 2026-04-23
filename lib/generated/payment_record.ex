defmodule Stripe.PaymentRecord do
  use Stripe.Entity

  @moduledoc "A Payment Record is a resource that allows you to represent payments that occur on- or off-Stripe.\nFor example, you can create a Payment Record to model a payment made on a different payment processor,\nin order to mark an Invoice as paid and a Subscription as active. Payment Records consist of one or\nmore Payment Attempt Records, which represent individual attempts made on a payment network."
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
      :latest_payment_attempt_record,
      :livemode,
      :metadata,
      :object,
      :payment_method_details,
      :processor_details,
      :shipping_details
    ]

    @typedoc "The `payment_record` type.\n\n  * `amount` \n  * `amount_authorized` \n  * `amount_canceled` \n  * `amount_failed` \n  * `amount_guaranteed` \n  * `amount_refunded` \n  * `amount_requested` \n  * `application` ID of the Connect application that created the PaymentRecord.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer_details` Customer information for this payment.\n  * `customer_presence` Indicates whether the customer was present in your checkout flow during this payment.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `id` Unique identifier for the object.\n  * `latest_payment_attempt_record` ID of the latest Payment Attempt Record attached to this Payment Record.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_method_details` Information about the Payment Method debited for this payment.\n  * `processor_details` \n  * `shipping_details` Shipping information for this payment.\n"
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
            latest_payment_attempt_record: binary | nil,
            livemode: boolean,
            metadata: term,
            object: binary,
            payment_method_details: term | nil,
            processor_details: term,
            shipping_details: term | nil
          }
  )

  (
    @typedoc "The billing address associated with the method of payment."
    @type address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    @typedoc "A positive integer in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal) representing how much of this payment to refund. Can refund only up to the remaining, unrefunded amount of the payment."
    @type amount :: %{optional(:currency) => binary, optional(:value) => integer}
  )

  (
    @typedoc "The amount you initially requested for this payment."
    @type amount_requested :: %{optional(:currency) => binary, optional(:value) => integer}
  )

  (
    @typedoc "The billing details associated with the method of payment."
    @type billing_details :: %{
            optional(:address) => address,
            optional(:email) => binary,
            optional(:name) => binary,
            optional(:phone) => binary
          }
  )

  (
    @typedoc "Information about the custom (user-defined) payment method used to make this payment."
    @type custom :: %{optional(:display_name) => binary, optional(:type) => binary}
  )

  (
    @typedoc "Customer information for this payment."
    @type customer_details :: %{
            optional(:customer) => binary,
            optional(:email) => binary,
            optional(:name) => binary,
            optional(:phone) => binary
          }
  )

  (
    @typedoc "Information about the payment attempt failure."
    @type failed :: %{optional(:failed_at) => integer}
  )

  (
    @typedoc "Information about the payment attempt guarantee."
    @type guaranteed :: %{optional(:guaranteed_at) => integer}
  )

  (
    @typedoc "Information about the Payment Method debited for this payment."
    @type payment_method_details :: %{
            optional(:billing_details) => billing_details,
            optional(:custom) => custom,
            optional(:payment_method) => binary,
            optional(:type) => :custom
          }
  )

  (
    @typedoc "Processor information for this refund."
    @type processor_details :: %{optional(:custom) => custom, optional(:type) => :custom}
  )

  (
    @typedoc "Information about the payment attempt refund."
    @type refunded :: %{optional(:refunded_at) => integer}
  )

  (
    @typedoc "Shipping information for this payment."
    @type shipping_details :: %{
            optional(:address) => address,
            optional(:name) => binary,
            optional(:phone) => binary
          }
  )

  (
    nil

    @doc "<p>Retrieves a Payment Record with the given ID</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_records/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_records/{id}",
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

  (
    nil

    @doc "<p>Report a new payment attempt on the specified Payment Record. A new payment\n attempt can only be specified if all other payment attempts are canceled or failed.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_records/{id}/report_payment_attempt`\n"
    (
      @spec report_payment_attempt(
              id :: binary(),
              params :: %{
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:failed) => failed,
                optional(:guaranteed) => guaranteed,
                optional(:initiated_at) => integer,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:outcome) => :failed | :guaranteed,
                optional(:payment_method_details) => payment_method_details,
                optional(:shipping_details) => shipping_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def report_payment_attempt(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_records/{id}/report_payment_attempt",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Report that the most recent payment attempt on the specified Payment Record\n was canceled.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_records/{id}/report_payment_attempt_canceled`\n"
    (
      @spec report_payment_attempt_canceled(
              id :: binary(),
              params :: %{
                optional(:canceled_at) => integer,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def report_payment_attempt_canceled(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_records/{id}/report_payment_attempt_canceled",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Report that the most recent payment attempt on the specified Payment Record\n failed or errored.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_records/{id}/report_payment_attempt_failed`\n"
    (
      @spec report_payment_attempt_failed(
              id :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:failed_at) => integer,
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def report_payment_attempt_failed(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_records/{id}/report_payment_attempt_failed",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Report that the most recent payment attempt on the specified Payment Record\n was guaranteed.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_records/{id}/report_payment_attempt_guaranteed`\n"
    (
      @spec report_payment_attempt_guaranteed(
              id :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:guaranteed_at) => integer,
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def report_payment_attempt_guaranteed(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_records/{id}/report_payment_attempt_guaranteed",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Report informational updates on the specified Payment Record.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_records/{id}/report_payment_attempt_informational`\n"
    (
      @spec report_payment_attempt_informational(
              id :: binary(),
              params :: %{
                optional(:customer_details) => customer_details,
                optional(:description) => binary | binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:shipping_details) => shipping_details | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def report_payment_attempt_informational(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_records/{id}/report_payment_attempt_informational",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Report that the most recent payment attempt on the specified Payment Record\n was refunded.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_records/{id}/report_refund`\n"
    (
      @spec report_refund(
              id :: binary(),
              params :: %{
                optional(:amount) => amount,
                optional(:expand) => list(binary),
                optional(:initiated_at) => integer,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:outcome) => :refunded,
                optional(:processor_details) => processor_details,
                optional(:refunded) => refunded
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def report_refund(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_records/{id}/report_refund",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Report a new Payment Record. You may report a Payment Record as it is\n initialized and later report updates through the other report_* methods, or report Payment\n Records in a terminal state directly, through this method.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_records/report_payment`\n"
    (
      @spec report_payment(
              params :: %{
                optional(:amount_requested) => amount_requested,
                optional(:customer_details) => customer_details,
                optional(:customer_presence) => :off_session | :on_session,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:failed) => failed,
                optional(:guaranteed) => guaranteed,
                optional(:initiated_at) => integer,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:outcome) => :failed | :guaranteed,
                optional(:payment_method_details) => payment_method_details,
                optional(:processor_details) => processor_details,
                optional(:shipping_details) => shipping_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def report_payment(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/payment_records/report_payment", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end