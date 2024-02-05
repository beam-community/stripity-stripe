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
    @type ae :: %{optional(:type) => :standard}
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
    @type au :: %{optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in BE."
    @type be :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in BG."
    @type bg :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in CA."
    @type ca :: %{
            optional(:province_standard) => province_standard,
            optional(:type) => :province_standard | :simplified | :standard
          }
  )

  (
    @typedoc "Options for the registration in CH."
    @type ch :: %{optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in CL."
    @type cl :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in CO."
    @type co :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Specific options for a registration in the specified `country`."
    @type country_options :: %{
            optional(:vn) => vn,
            optional(:lv) => lv,
            optional(:cl) => cl,
            optional(:se) => se,
            optional(:pl) => pl,
            optional(:nz) => nz,
            optional(:lt) => lt,
            optional(:de) => de,
            optional(:fr) => fr,
            optional(:fi) => fi,
            optional(:sa) => sa,
            optional(:es) => es,
            optional(:sg) => sg,
            optional(:tr) => tr,
            optional(:sk) => sk,
            optional(:ie) => ie,
            optional(:th) => th,
            optional(:us) => us,
            optional(:co) => co,
            optional(:ee) => ee,
            optional(:hu) => hu,
            optional(:it) => it,
            optional(:jp) => jp,
            optional(:si) => si,
            optional(:kr) => kr,
            optional(:gb) => gb,
            optional(:ca) => ca,
            optional(:dk) => dk,
            optional(:nl) => nl,
            optional(:my) => my,
            optional(:ae) => ae,
            optional(:gr) => gr,
            optional(:ch) => ch,
            optional(:be) => be,
            optional(:cz) => cz,
            optional(:no) => no,
            optional(:lu) => lu,
            optional(:cy) => cy,
            optional(:au) => au,
            optional(:mt) => mt,
            optional(:is) => is,
            optional(:bg) => bg,
            optional(:za) => za,
            optional(:hr) => hr,
            optional(:id) => id,
            optional(:ro) => ro,
            optional(:mx) => mx,
            optional(:pt) => pt,
            optional(:at) => at
          }
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
    @typedoc "Options for the registration in EE."
    @type ee :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
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
    @type gb :: %{optional(:type) => :standard}
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
    @typedoc "Options for the registration in IS."
    @type is :: %{optional(:type) => :standard}
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
    @type jp :: %{optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in KR."
    @type kr :: %{optional(:type) => :simplified}
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
    @typedoc "Options for the registration in NL."
    @type nl :: %{
            optional(:standard) => standard,
            optional(:type) => :ioss | :oss_non_union | :oss_union | :standard
          }
  )

  (
    @typedoc "Options for the registration in NO."
    @type no :: %{optional(:type) => :standard}
  )

  (
    @typedoc "Options for the registration in NZ."
    @type nz :: %{optional(:type) => :standard}
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
    @type sg :: %{optional(:type) => :standard}
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
    @typedoc "Options for the standard registration."
    @type standard :: %{optional(:place_of_supply_scheme) => :small_seller | :standard}
  )

  (
    @typedoc "Options for the registration in TH."
    @type th :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in TR."
    @type tr :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in US."
    @type us :: %{
            optional(:local_amusement_tax) => local_amusement_tax,
            optional(:local_lease_tax) => local_lease_tax,
            optional(:state) => binary,
            optional(:type) =>
              :local_amusement_tax
              | :local_lease_tax
              | :state_communications_tax
              | :state_sales_tax
          }
  )

  (
    @typedoc "Options for the registration in VN."
    @type vn :: %{optional(:type) => :simplified}
  )

  (
    @typedoc "Options for the registration in ZA."
    @type za :: %{optional(:type) => :standard}
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
