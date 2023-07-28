defmodule Stripe.TaxRate do
  use Stripe.Entity

  @moduledoc "Tax rates can be applied to [invoices](https://stripe.com/docs/billing/invoices/tax-rates), [subscriptions](https://stripe.com/docs/billing/subscriptions/taxes) and [Checkout Sessions](https://stripe.com/docs/payments/checkout/set-up-a-subscription#tax-rates) to collect tax.\n\nRelated guide: [Tax rates](https://stripe.com/docs/billing/taxes/tax-rates)"
  (
    defstruct [
      :active,
      :country,
      :created,
      :description,
      :display_name,
      :effective_percentage,
      :id,
      :inclusive,
      :jurisdiction,
      :livemode,
      :metadata,
      :object,
      :percentage,
      :state,
      :tax_type
    ]

    @typedoc "The `tax_rate` type.\n\n  * `active` Defaults to `true`. When set to `false`, this tax rate cannot be used with new applications or Checkout Sessions, but will still work for subscriptions and invoices that already have it set.\n  * `country` Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `description` An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.\n  * `display_name` The display name of the tax rates as it will appear to your customer on their receipt email, PDF, and the hosted invoice page.\n  * `effective_percentage` Actual/effective tax rate percentage out of 100. For tax calculations with automatic_tax[enabled]=true, this percentage does not include the statutory tax rate of non-taxable jurisdictions.\n  * `id` Unique identifier for the object.\n  * `inclusive` This specifies if the tax rate is inclusive or exclusive.\n  * `jurisdiction` The jurisdiction for the tax rate. You can use this label field for tax reporting purposes. It also appears on your customer’s invoice.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `percentage` Tax rate percentage out of 100. For tax calculations with automatic_tax[enabled]=true, this percentage includes the statutory tax rate of non-taxable jurisdictions.\n  * `state` [ISO 3166-2 subdivision code](https://en.wikipedia.org/wiki/ISO_3166-2:US), without country prefix. For example, \"NY\" for New York, United States.\n  * `tax_type` The high-level tax type, such as `vat` or `sales_tax`.\n"
    @type t :: %__MODULE__{
            active: boolean,
            country: binary | nil,
            created: integer,
            description: binary | nil,
            display_name: binary,
            effective_percentage: term | nil,
            id: binary,
            inclusive: boolean,
            jurisdiction: binary | nil,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            percentage: term,
            state: binary | nil,
            tax_type: binary | nil
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

    @doc "<p>Returns a list of your tax rates. Tax rates are returned sorted by creation date, with the most recently created tax rates appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax_rates`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:inclusive) => boolean,
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.TaxRate.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax_rates", [], [])

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

    @doc "<p>Retrieves a tax rate with the given ID</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax_rates/{tax_rate}`\n"
    (
      @spec retrieve(
              tax_rate :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.TaxRate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(tax_rate, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax_rates/{tax_rate}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "tax_rate",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "tax_rate",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [tax_rate]
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

    @doc "<p>Creates a new tax rate.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax_rates`\n"
    (
      @spec create(
              params :: %{
                optional(:active) => boolean,
                optional(:country) => binary,
                optional(:description) => binary,
                optional(:display_name) => binary,
                optional(:expand) => list(binary),
                optional(:inclusive) => boolean,
                optional(:jurisdiction) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:percentage) => number,
                optional(:state) => binary,
                optional(:tax_type) =>
                  :amusement_tax
                  | :communications_tax
                  | :gst
                  | :hst
                  | :igst
                  | :jct
                  | :lease_tax
                  | :pst
                  | :qst
                  | :rst
                  | :sales_tax
                  | :service_tax
                  | :vat
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.TaxRate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax_rates", [], [])

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

    @doc "<p>Updates an existing tax rate.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax_rates/{tax_rate}`\n"
    (
      @spec update(
              tax_rate :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:country) => binary,
                optional(:description) => binary,
                optional(:display_name) => binary,
                optional(:expand) => list(binary),
                optional(:jurisdiction) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:state) => binary,
                optional(:tax_type) =>
                  :amusement_tax
                  | :communications_tax
                  | :gst
                  | :hst
                  | :igst
                  | :jct
                  | :lease_tax
                  | :pst
                  | :qst
                  | :rst
                  | :sales_tax
                  | :service_tax
                  | :vat
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.TaxRate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(tax_rate, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax_rates/{tax_rate}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "tax_rate",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "tax_rate",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [tax_rate]
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