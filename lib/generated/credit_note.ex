defmodule Stripe.CreditNote do
  use Stripe.Entity

  @moduledoc "Issue a credit note to adjust an invoice's amount after the invoice is finalized.\n\nRelated guide: [Credit notes](https://stripe.com/docs/billing/invoices/credit-notes)"
  (
    defstruct [
      :amount,
      :amount_shipping,
      :created,
      :currency,
      :customer,
      :customer_balance_transaction,
      :discount_amount,
      :discount_amounts,
      :effective_at,
      :id,
      :invoice,
      :lines,
      :livemode,
      :memo,
      :metadata,
      :number,
      :object,
      :out_of_band_amount,
      :pdf,
      :reason,
      :refund,
      :shipping_cost,
      :status,
      :subtotal,
      :subtotal_excluding_tax,
      :tax_amounts,
      :total,
      :total_excluding_tax,
      :type,
      :voided_at
    ]

    @typedoc "The `credit_note` type.\n\n  * `amount` The integer amount in cents (or local equivalent) representing the total amount of the credit note, including tax.\n  * `amount_shipping` This is the sum of all the shipping amounts.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` ID of the customer.\n  * `customer_balance_transaction` Customer balance transaction related to this credit note.\n  * `discount_amount` The integer amount in cents (or local equivalent) representing the total amount of discount that was credited.\n  * `discount_amounts` The aggregate amounts calculated per discount for all line items.\n  * `effective_at` The date when this credit note is in effect. Same as `created` unless overwritten. When defined, this value replaces the system-generated 'Date of issue' printed on the credit note PDF.\n  * `id` Unique identifier for the object.\n  * `invoice` ID of the invoice.\n  * `lines` Line items that make up the credit note\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `memo` Customer-facing text that appears on the credit note PDF.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `number` A unique number that identifies this particular credit note and appears on the PDF of the credit note and its associated invoice.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `out_of_band_amount` Amount that was credited outside of Stripe.\n  * `pdf` The link to download the PDF of the credit note.\n  * `reason` Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`\n  * `refund` Refund related to this credit note.\n  * `shipping_cost` The details of the cost of shipping, including the ShippingRate applied to the invoice.\n  * `status` Status of this credit note, one of `issued` or `void`. Learn more about [voiding credit notes](https://stripe.com/docs/billing/invoices/credit-notes#voiding).\n  * `subtotal` The integer amount in cents (or local equivalent) representing the amount of the credit note, excluding exclusive tax and invoice level discounts.\n  * `subtotal_excluding_tax` The integer amount in cents (or local equivalent) representing the amount of the credit note, excluding all tax and invoice level discounts.\n  * `tax_amounts` The aggregate amounts calculated per tax rate for all line items.\n  * `total` The integer amount in cents (or local equivalent) representing the total amount of the credit note, including tax and all discount.\n  * `total_excluding_tax` The integer amount in cents (or local equivalent) representing the total amount of the credit note, excluding tax, but including discounts.\n  * `type` Type of this credit note, one of `pre_payment` or `post_payment`. A `pre_payment` credit note means it was issued when the invoice was open. A `post_payment` credit note means it was issued when the invoice was paid.\n  * `voided_at` The time that the credit note was voided.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_shipping: integer,
            created: integer,
            currency: binary,
            customer: binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t(),
            customer_balance_transaction: (binary | Stripe.CustomerBalanceTransaction.t()) | nil,
            discount_amount: integer,
            discount_amounts: term,
            effective_at: integer | nil,
            id: binary,
            invoice: binary | Stripe.Invoice.t(),
            lines: term,
            livemode: boolean,
            memo: binary | nil,
            metadata: term | nil,
            number: binary,
            object: binary,
            out_of_band_amount: integer | nil,
            pdf: binary,
            reason: binary | nil,
            refund: (binary | Stripe.Refund.t()) | nil,
            shipping_cost: term | nil,
            status: binary,
            subtotal: integer,
            subtotal_excluding_tax: integer | nil,
            tax_amounts: term,
            total: integer,
            total_excluding_tax: integer | nil,
            type: binary,
            voided_at: integer | nil
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
    @type lines :: %{
            optional(:amount) => integer,
            optional(:description) => binary,
            optional(:invoice_line_item) => binary,
            optional(:quantity) => integer,
            optional(:tax_amounts) => list(tax_amounts) | binary,
            optional(:tax_rates) => list(binary) | binary,
            optional(:type) => :custom_line_item | :invoice_line_item,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary
          }
  )

  (
    @typedoc nil
    @type shipping_cost :: %{optional(:shipping_rate) => binary}
  )

  (
    @typedoc nil
    @type tax_amounts :: %{
            optional(:amount) => integer,
            optional(:tax_rate) => binary,
            optional(:taxable_amount) => integer
          }
  )

  (
    nil

    @doc "<p>Returns a list of credit notes.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/credit_notes`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:invoice) => binary,
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.CreditNote.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/credit_notes", [], [])

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

    @doc "<p>Retrieves the credit note object with the given identifier.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/credit_notes/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CreditNote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/credit_notes/{id}",
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

  (
    nil

    @doc "<p>Get a preview of a credit note without creating it.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/credit_notes/preview`\n"
    (
      @spec preview(
              params :: %{
                optional(:amount) => integer,
                optional(:credit_amount) => integer,
                optional(:effective_at) => integer,
                optional(:email_type) => :credit_note | :none,
                optional(:expand) => list(binary),
                optional(:invoice) => binary,
                optional(:lines) => list(lines),
                optional(:memo) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:out_of_band_amount) => integer,
                optional(:reason) =>
                  :duplicate | :fraudulent | :order_change | :product_unsatisfactory,
                optional(:refund) => binary,
                optional(:refund_amount) => integer,
                optional(:shipping_cost) => shipping_cost
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CreditNote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def preview(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/credit_notes/preview", [], [])

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

    @doc "<p>When retrieving a credit note preview, you’ll get a <strong>lines</strong> property containing the first handful of those items. This URL you can retrieve the full (paginated) list of line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/credit_notes/preview/lines`\n"
    (
      @spec preview_lines(
              params :: %{
                optional(:amount) => integer,
                optional(:credit_amount) => integer,
                optional(:effective_at) => integer,
                optional(:email_type) => :credit_note | :none,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:invoice) => binary,
                optional(:limit) => integer,
                optional(:lines) => list(lines),
                optional(:memo) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:out_of_band_amount) => integer,
                optional(:reason) =>
                  :duplicate | :fraudulent | :order_change | :product_unsatisfactory,
                optional(:refund) => binary,
                optional(:refund_amount) => integer,
                optional(:shipping_cost) => shipping_cost,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.CreditNoteLineItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def preview_lines(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/credit_notes/preview/lines", [], [])

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

    @doc "<p>Issue a credit note to adjust the amount of a finalized invoice. For a <code>status=open</code> invoice, a credit note reduces\nits <code>amount_due</code>. For a <code>status=paid</code> invoice, a credit note does not affect its <code>amount_due</code>. Instead, it can result\nin any combination of the following:</p>\n\n<ul>\n<li>Refund: create a new refund (using <code>refund_amount</code>) or link an existing refund (using <code>refund</code>).</li>\n<li>Customer balance credit: credit the customer’s balance (using <code>credit_amount</code>) which will be automatically applied to their next invoice when it’s finalized.</li>\n<li>Outside of Stripe credit: record the amount that is or will be credited outside of Stripe (using <code>out_of_band_amount</code>).</li>\n</ul>\n\n<p>For post-payment credit notes the sum of the refund, credit and outside of Stripe amounts must equal the credit note total.</p>\n\n<p>You may issue multiple credit notes for an invoice. Each credit note will increment the invoice’s <code>pre_payment_credit_notes_amount</code>\nor <code>post_payment_credit_notes_amount</code> depending on its <code>status</code> at the time of credit note creation.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/credit_notes`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:credit_amount) => integer,
                optional(:effective_at) => integer,
                optional(:email_type) => :credit_note | :none,
                optional(:expand) => list(binary),
                optional(:invoice) => binary,
                optional(:lines) => list(lines),
                optional(:memo) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:out_of_band_amount) => integer,
                optional(:reason) =>
                  :duplicate | :fraudulent | :order_change | :product_unsatisfactory,
                optional(:refund) => binary,
                optional(:refund_amount) => integer,
                optional(:shipping_cost) => shipping_cost
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CreditNote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/credit_notes", [], [])

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

    @doc "<p>Updates an existing credit note.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/credit_notes/{id}`\n"
    (
      @spec update(
              id :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:memo) => binary,
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CreditNote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/credit_notes/{id}",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Marks a credit note as void. Learn more about <a href=\"/docs/billing/invoices/credit-notes#voiding\">voiding credit notes</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/credit_notes/{id}/void`\n"
    (
      @spec void_credit_note(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CreditNote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def void_credit_note(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/credit_notes/{id}/void",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end