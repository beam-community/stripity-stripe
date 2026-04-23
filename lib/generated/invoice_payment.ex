defmodule Stripe.InvoicePayment do
  use Stripe.Entity

  @moduledoc "Invoice Payments represent payments made against invoices. Invoice Payments can\nbe accessed in two ways:\n1. By expanding the `payments` field on the [Invoice](https://stripe.com/docs/api#invoice) resource.\n2. By using the Invoice Payment retrieve and list endpoints.\n\nInvoice Payments include the mapping between payment objects, such as Payment Intent, and Invoices.\nThis resource and its endpoints allows you to easily track if a payment is associated with a specific invoice and\nmonitor the allocation details of the payments."
  (
    defstruct [
      :amount_paid,
      :amount_requested,
      :created,
      :currency,
      :id,
      :invoice,
      :is_default,
      :livemode,
      :object,
      :payment,
      :status,
      :status_transitions
    ]

    @typedoc "The `invoice_payment` type.\n\n  * `amount_paid` Amount that was actually paid for this invoice, in cents (or local equivalent). This field is null until the payment is `paid`. This amount can be less than the `amount_requested` if the PaymentIntent’s `amount_received` is not sufficient to pay all of the invoices that it is attached to.\n  * `amount_requested` Amount intended to be paid toward this invoice, in cents (or local equivalent)\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `id` Unique identifier for the object.\n  * `invoice` The invoice that was paid.\n  * `is_default` Stripe automatically creates a default InvoicePayment when the invoice is finalized, and keeps it synchronized with the invoice’s `amount_remaining`. The PaymentIntent associated with the default payment can’t be edited or canceled directly.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment` \n  * `status` The status of the payment, one of `open`, `paid`, or `canceled`.\n  * `status_transitions` \n"
    @type t :: %__MODULE__{
            amount_paid: integer | nil,
            amount_requested: integer,
            created: integer,
            currency: binary,
            id: binary,
            invoice: binary | Stripe.Invoice.t() | Stripe.DeletedInvoice.t(),
            is_default: boolean,
            livemode: boolean,
            object: binary,
            payment: term,
            status: binary,
            status_transitions: term
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
    @typedoc nil
    @type payment :: %{
            optional(:payment_intent) => binary,
            optional(:payment_record) => binary,
            optional(:type) => :payment_intent | :payment_record
          }
  )

  (
    nil

    @doc "<p>When retrieving an invoice, there is an includable payments property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of payments.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoice_payments`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:invoice) => binary,
                optional(:limit) => integer,
                optional(:payment) => payment,
                optional(:starting_after) => binary,
                optional(:status) => :canceled | :open | :paid
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.InvoicePayment.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoice_payments", [], [])

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

    @doc "<p>Retrieves the invoice payment with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoice_payments/{invoice_payment}`\n"
    (
      @spec retrieve(
              invoice_payment :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.InvoicePayment.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(invoice_payment, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoice_payments/{invoice_payment}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "invoice_payment",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "invoice_payment",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [invoice_payment]
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