# credo:disable-for-this-file
defmodule Stripe.Tax.Registration do
  use Stripe.Entity

  @moduledoc "A Tax `Registration` lets us know that your business is registered to collect tax on payments within a region, enabling you to [automatically collect tax](https://stripe.com/docs/tax).\n\nStripe doesn't register on your behalf with the relevant authorities when you create a Tax `Registration` object. For more information on how to register to collect tax, see [our guide](https://stripe.com/docs/tax/registering).\n\nRelated guide: [Using the Registrations API](https://stripe.com/docs/tax/registrations-api)"
  (
    defstruct [
      :active_from,
      :country,
      :country_options,
      :created,
      :expires_at,
      :id,
      :livemode,
      :object,
      :status
    ]

    @typedoc "The `tax.registration` type.\n\n  * `active_from` Time at which the registration becomes active. Measured in seconds since the Unix epoch.\n  * `country` Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).\n  * `country_options` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `expires_at` If set, the registration stops being active at this time. If not set, the registration will be active indefinitely. Measured in seconds since the Unix epoch.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` The status of the registration. This field is present for convenience and can be deduced from `active_from` and `expires_at`.\n"
    @type t :: %__MODULE__{
            active_from: integer,
            country: binary,
            country_options: term,
            created: integer,
            expires_at: integer | nil,
            id: binary,
            livemode: boolean,
            object: binary,
            status: binary
          }
  )

  (
    @typedoc "Options for the registration in AE."
    @type ae :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in AL."
    @type al :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in AM."
    @type am :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in AO."
    @type ao :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in AT."
    @type at :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in AU."
    @type au :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in AW."
    @type aw :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in AZ."
    @type az :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in BA."
    @type ba :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in BB."
    @type bb :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in BD."
    @type bd :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in BE."
    @type be :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in BF."
    @type bf :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in BG."
    @type bg :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in BH."
    @type bh :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in BJ."
    @type bj :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in BS."
    @type bs :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in BY."
    @type by :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in CA."
    @type ca :: %{
            optional(:province_standard) => province_standard,
            optional(:type) => :province_standard | :simplified | :standard
          }
  )

  (
    @typedoc "Options for the registration in CD."
    @type cd :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in CH."
    @type ch :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in CL."
    @type cl :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in CM."
    @type cm :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in CO."
    @type co :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Specific options for a registration in the specified `country`."
    @type country_options :: %{
            optional(:is) => is,
            optional(:ec) => ec,
            optional(:th) => th,
            optional(:bd) => bd,
            optional(:bf) => bf,
            optional(:fi) => fi,
            optional(:om) => om,
            optional(:ee) => ee,
            optional(:me) => me,
            optional(:am) => am,
            optional(:gr) => gr,
            optional(:cv) => cv,
            optional(:ug) => ug,
            optional(:zw) => zw,
            optional(:cd) => cd,
            optional(:sa) => sa,
            optional(:sn) => sn,
            optional(:tz) => tz,
            optional(:bh) => bh,
            optional(:be) => be,
            optional(:kh) => kh,
            optional(:mt) => mt,
            optional(:fr) => fr,
            optional(:eg) => eg,
            optional(:pl) => pl,
            optional(:de) => de,
            optional(:ge) => ge,
            optional(:co) => co,
            optional(:np) => np,
            optional(:kz) => kz,
            optional(:ch) => ch,
            optional(:se) => se,
            optional(:sk) => sk,
            optional(:us) => us,
            optional(:cy) => cy,
            optional(:au) => au,
            optional(:md) => md,
            optional(:si) => si,
            optional(:kg) => kg,
            optional(:it) => it,
            optional(:vn) => vn,
            optional(:mr) => mr,
            optional(:hr) => hr,
            optional(:zm) => zm,
            optional(:by) => by,
            optional(:bb) => bb,
            optional(:ro) => ro,
            optional(:bs) => bs,
            optional(:mx) => mx,
            optional(:ie) => ie,
            optional(:id) => id,
            optional(:es) => es,
            optional(:sg) => sg,
            optional(:gn) => gn,
            optional(:ru) => ru,
            optional(:cl) => cl,
            optional(:hu) => hu,
            optional(:kr) => kr,
            optional(:az) => az,
            optional(:ae) => ae,
            optional(:ke) => ke,
            optional(:jp) => jp,
            optional(:lv) => lv,
            optional(:no) => no,
            optional(:cz) => cz,
            optional(:ca) => ca,
            optional(:tj) => tj,
            optional(:al) => al,
            optional(:ph) => ph,
            optional(:in) => in_field,
            optional(:tw) => tw,
            optional(:cr) => cr,
            optional(:nz) => nz,
            optional(:dk) => dk,
            optional(:my) => my,
            optional(:la) => la,
            optional(:sr) => sr,
            optional(:mk) => mk,
            optional(:nl) => nl,
            optional(:lu) => lu,
            optional(:ao) => ao,
            optional(:uz) => uz,
            optional(:ba) => ba,
            optional(:za) => za,
            optional(:cm) => cm,
            optional(:lt) => lt,
            optional(:pe) => pe,
            optional(:bg) => bg,
            optional(:rs) => rs,
            optional(:ua) => ua,
            optional(:tr) => tr,
            optional(:uy) => uy,
            optional(:aw) => aw,
            optional(:ma) => ma,
            optional(:at) => at,
            optional(:ng) => ng,
            optional(:gb) => gb,
            optional(:et) => et,
            optional(:pt) => pt,
            optional(:bj) => bj
          }
  )

  (
    @typedoc "Options for the registration in CR."
    @type cr :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in CV."
    @type cv :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in CY."
    @type cy :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in CZ."
    @type cz :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in DE."
    @type de :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in DK."
    @type dk :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in EC."
    @type ec :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in EE."
    @type ee :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in EG."
    @type eg :: %{optional(:type) => :simplified}
  )

  (
    @typedoc nil
    @type elections :: %{
            optional(:jurisdiction) => binary,
            optional(:type) => :local_use_tax | :simplified_sellers_use_tax | :single_local_use_tax
          }
  )

  (
    @typedoc "Options for the registration in ES."
    @type es :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in ET."
    @type et :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in FI."
    @type fi :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in FR."
    @type fr :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in GB."
    @type gb :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in GE."
    @type ge :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in GN."
    @type gn :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in GR."
    @type gr :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in HR."
    @type hr :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in HU."
    @type hu :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in ID."
    @type id :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in IE."
    @type ie :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in IN."
    @type in_field :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in IS."
    @type is :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in IT."
    @type it :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in JP."
    @type jp :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in KE."
    @type ke :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in KG."
    @type kg :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in KH."
    @type kh :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in KR."
    @type kr :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in KZ."
    @type kz :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in LA."
    @type la :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the local amusement tax registration."
    @type local_amusement_tax :: %{optional(:jurisdiction) => binary}
  )

  (
    @typedoc "Options for the local lease tax registration."
    @type local_lease_tax :: %{optional(:jurisdiction) => binary}
  )

  (
    @typedoc "Options for the registration in LT."
    @type lt :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in LU."
    @type lu :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in LV."
    @type lv :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in MA."
    @type ma :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in MD."
    @type md :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in ME."
    @type me :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in MK."
    @type mk :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in MR."
    @type mr :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in MT."
    @type mt :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in MX."
    @type mx :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in MY."
    @type my :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in NG."
    @type ng :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in NL."
    @type nl :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in NO."
    @type no :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in NP."
    @type np :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in NZ."
    @type nz :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in OM."
    @type om :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in PE."
    @type pe :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in PH."
    @type ph :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in PL."
    @type pl :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the provincial tax registration."
    @type province_standard :: %{optional(:province) => binary}
  )

  (
    @typedoc "Options for the registration in PT."
    @type pt :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in RO."
    @type ro :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in RS."
    @type rs :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in RU."
    @type ru :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in SA."
    @type sa :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in SE."
    @type se :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in SG."
    @type sg :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in SI."
    @type si :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in SK."
    @type sk :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in SN."
    @type sn :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in SR."
    @type sr :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the standard registration."
    @type standard :: %{optional(:place_of_supply_scheme) => :inbound_goods | :standard}
  )

  (
    @typedoc "Options for the state sales tax registration."
    @type state_sales_tax :: %{optional(:elections) => list(elections)}
  )

  (
    @typedoc "Options for the registration in TH."
    @type th :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in TJ."
    @type tj :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in TR."
    @type tr :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in TW."
    @type tw :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in TZ."
    @type tz :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in UA."
    @type ua :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in UG."
    @type ug :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in US."
    @type us :: %{
            optional(:local_amusement_tax) => local_amusement_tax,
            optional(:local_lease_tax) => local_lease_tax,
            optional(:state) => binary,
            optional(:state_sales_tax) => state_sales_tax,
            optional(:type) =>
              :local_amusement_tax
              | :local_lease_tax
              | :state_communications_tax
              | :state_retail_delivery_fee
              | :state_sales_tax
          }
  )

  (
    @typedoc "Options for the registration in UY."
    @type uy :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in UZ."
    @type uz :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in VN."
    @type vn :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in ZA."
    @type za :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in ZM."
    @type zm :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in ZW."
    @type zw :: %{optional(:standard) => standard, optional(:type) => :standard}
  )

  (
    nil

    @doc "<p>Returns a list of Tax <code>Registration</code> objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax/registrations`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :active | :all | :expired | :scheduled
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Tax.Registration.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax/registrations", [], [])

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

    @doc "<p>Returns a Tax <code>Registration</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax/registrations/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Registration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax/registrations/{id}",
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

    @doc "<p>Creates a new Tax <code>Registration</code> object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax/registrations`\n"
    (
      @spec create(
              params :: %{
                optional(:active_from) => :now | integer,
                optional(:country) => binary,
                optional(:country_options) => country_options,
                optional(:expand) => list(binary),
                optional(:expires_at) => integer
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Registration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax/registrations", [], [])

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

    @doc "<p>Updates an existing Tax <code>Registration</code> object.</p>\n\n<p>A registration cannot be deleted after it has been created. If you wish to end a registration you may do so by setting <code>expires_at</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax/registrations/{id}`\n"
    (
      @spec update(
              id :: binary(),
              params :: %{
                optional(:active_from) => :now | integer,
                optional(:expand) => list(binary),
                optional(:expires_at) => :now | integer | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Registration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax/registrations/{id}",
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
end
