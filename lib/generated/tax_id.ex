defmodule Stripe.TaxId do
  use Stripe.Entity

  @moduledoc "You can add one or multiple tax IDs to a [customer](https://stripe.com/docs/api/customers).\nA customer's tax IDs are displayed on invoices and credit notes issued for the customer.\n\nRelated guide: [Customer tax identification numbers](https://stripe.com/docs/billing/taxes/tax-ids)"
  (
    defstruct [
      :country,
      :created,
      :customer,
      :id,
      :livemode,
      :object,
      :type,
      :value,
      :verification
    ]

    @typedoc "The `tax_id` type.\n\n  * `country` Two-letter ISO code representing the country of the tax ID.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` ID of the customer.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `type` Type of the tax ID, one of `ad_nrt`, `ae_trn`, `ar_cuit`, `au_abn`, `au_arn`, `bg_uic`, `bo_tin`, `br_cnpj`, `br_cpf`, `ca_bn`, `ca_gst_hst`, `ca_pst_bc`, `ca_pst_mb`, `ca_pst_sk`, `ca_qst`, `ch_vat`, `cl_tin`, `cn_tin`, `co_nit`, `cr_tin`, `do_rcn`, `ec_ruc`, `eg_tin`, `es_cif`, `eu_oss_vat`, `eu_vat`, `gb_vat`, `ge_vat`, `hk_br`, `hu_tin`, `id_npwp`, `il_vat`, `in_gst`, `is_vat`, `jp_cn`, `jp_rn`, `jp_trn`, `ke_pin`, `kr_brn`, `li_uid`, `mx_rfc`, `my_frp`, `my_itn`, `my_sst`, `no_vat`, `nz_gst`, `pe_ruc`, `ph_tin`, `ro_tin`, `rs_pib`, `ru_inn`, `ru_kpp`, `sa_vat`, `sg_gst`, `sg_uen`, `si_tin`, `sv_nit`, `th_vat`, `tr_tin`, `tw_vat`, `ua_vat`, `us_ein`, `uy_ruc`, `ve_rif`, `vn_tin`, or `za_vat`. Note that some legacy tax IDs have type `unknown`\n  * `value` Value of the tax ID.\n  * `verification` Tax ID verification information.\n"
    @type t :: %__MODULE__{
            country: binary | nil,
            created: integer,
            customer: (binary | Stripe.Customer.t()) | nil,
            id: binary,
            livemode: boolean,
            object: binary,
            type: binary,
            value: binary,
            verification: term | nil
          }
  )

  (
    nil

    @doc "<p>Creates a new <code>TaxID</code> object for a customer.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers/{customer}/tax_ids`\n"
    (
      @spec create(
              customer :: binary(),
              params :: %{
                optional(:expand) => list(binary),
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
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.TaxId.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/tax_ids",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Retrieves the <code>TaxID</code> object with the given identifier.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/tax_ids/{id}`\n"
    (
      @spec retrieve(
              customer :: binary(),
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.TaxId.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(customer, id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/tax_ids/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
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
            [customer, id]
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

    @doc "<p>Returns a list of tax IDs for a customer.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/tax_ids`\n"
    (
      @spec list(
              customer :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.TaxId.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/tax_ids",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Deletes an existing <code>TaxID</code> object.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/customers/{customer}/tax_ids/{id}`\n"
    (
      @spec delete(customer :: binary(), id :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedTaxId.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete(customer, id, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/tax_ids/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
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
            [customer, id]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end