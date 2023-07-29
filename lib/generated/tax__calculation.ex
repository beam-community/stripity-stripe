defmodule Stripe.Tax.Calculation do
  use Stripe.Entity

  @moduledoc "A Tax Calculation allows you to calculate the tax to collect from your customer.\n\nRelated guide: [Calculate tax in your custom payment flow](https://stripe.com/docs/tax/custom)"
  (
    defstruct [
      :amount_total,
      :currency,
      :customer,
      :customer_details,
      :expires_at,
      :id,
      :line_items,
      :livemode,
      :object,
      :shipping_cost,
      :tax_amount_exclusive,
      :tax_amount_inclusive,
      :tax_breakdown,
      :tax_date
    ]

    @typedoc "The `tax.calculation` type.\n\n  * `amount_total` Total after taxes.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` The ID of an existing [Customer](https://stripe.com/docs/api/customers/object) used for the resource.\n  * `customer_details` \n  * `expires_at` Timestamp of date at which the tax calculation will expire.\n  * `id` Unique identifier for the calculation.\n  * `line_items` The list of items the customer is purchasing.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `shipping_cost` The shipping cost details for the calculation.\n  * `tax_amount_exclusive` The amount of tax to be collected on top of the line item prices.\n  * `tax_amount_inclusive` The amount of tax already included in the line item prices.\n  * `tax_breakdown` Breakdown of individual tax amounts that add up to the total.\n  * `tax_date` Timestamp of date at which the tax rules and rates in effect applies for the calculation.\n"
    @type t :: %__MODULE__{
            amount_total: integer,
            currency: binary,
            customer: binary | nil,
            customer_details: term,
            expires_at: integer | nil,
            id: binary | nil,
            line_items: term | nil,
            livemode: boolean,
            object: binary,
            shipping_cost: term | nil,
            tax_amount_exclusive: integer,
            tax_amount_inclusive: integer,
            tax_breakdown: term,
            tax_date: integer
          }
  )

  (
    @typedoc "The customer's postal address (for example, home or business location)."
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
    @typedoc "Details about the customer, including address and tax IDs."
    @type customer_details :: %{
            optional(:address) => address,
            optional(:address_source) => :billing | :shipping,
            optional(:ip_address) => binary,
            optional(:tax_ids) => list(tax_ids),
            optional(:taxability_override) => :customer_exempt | :none | :reverse_charge
          }
  )

  (
    @typedoc nil
    @type line_items :: %{
            optional(:amount) => integer,
            optional(:product) => binary,
            optional(:quantity) => integer,
            optional(:reference) => binary,
            optional(:tax_behavior) => :exclusive | :inclusive,
            optional(:tax_code) => binary
          }
  )

  (
    @typedoc "Shipping cost details to be used for the calculation."
    @type shipping_cost :: %{
            optional(:amount) => integer,
            optional(:shipping_rate) => binary,
            optional(:tax_behavior) => :exclusive | :inclusive,
            optional(:tax_code) => binary
          }
  )

  (
    @typedoc nil
    @type tax_ids :: %{
            optional(:type) =>
              :ad_nrt
              | :ae_trn
              | :ar_cuit
              | :au_abn
              | :au_arn
              | :bg_uic
              | :bo_tin
              | :br_cnpj
              | :br_cpf
              | :ca_bn
              | :ca_gst_hst
              | :ca_pst_bc
              | :ca_pst_mb
              | :ca_pst_sk
              | :ca_qst
              | :ch_vat
              | :cl_tin
              | :cn_tin
              | :co_nit
              | :cr_tin
              | :do_rcn
              | :ec_ruc
              | :eg_tin
              | :es_cif
              | :eu_oss_vat
              | :eu_vat
              | :gb_vat
              | :ge_vat
              | :hk_br
              | :hu_tin
              | :id_npwp
              | :il_vat
              | :in_gst
              | :is_vat
              | :jp_cn
              | :jp_rn
              | :jp_trn
              | :ke_pin
              | :kr_brn
              | :li_uid
              | :mx_rfc
              | :my_frp
              | :my_itn
              | :my_sst
              | :no_vat
              | :nz_gst
              | :pe_ruc
              | :ph_tin
              | :ro_tin
              | :rs_pib
              | :ru_inn
              | :ru_kpp
              | :sa_vat
              | :sg_gst
              | :sg_uen
              | :si_tin
              | :sv_nit
              | :th_vat
              | :tr_tin
              | :tw_vat
              | :ua_vat
              | :us_ein
              | :uy_ruc
              | :ve_rif
              | :vn_tin
              | :za_vat,
            optional(:value) => binary
          }
  )

  (
    nil

    @doc "<p>Calculates tax based on input and returns a Tax <code>Calculation</code> object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax/calculations`\n"
    (
      @spec create(
              params :: %{
                optional(:currency) => binary,
                optional(:customer) => binary,
                optional(:customer_details) => customer_details,
                optional(:expand) => list(binary),
                optional(:line_items) => list(line_items),
                optional(:shipping_cost) => shipping_cost,
                optional(:tax_date) => integer
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Calculation.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax/calculations", [], [])

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

    @doc "<p>Retrieves the line items of a persisted tax calculation as a collection.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax/calculations/{calculation}/line_items`\n"
    (
      @spec list_line_items(
              calculation :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Tax.CalculationLineItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list_line_items(calculation, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax/calculations/{calculation}/line_items",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "calculation",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "calculation",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [calculation]
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
