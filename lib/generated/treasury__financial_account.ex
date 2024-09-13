defmodule Stripe.Treasury.FinancialAccount do
  use Stripe.Entity

  @moduledoc "Stripe Treasury provides users with a container for money called a FinancialAccount that is separate from their Payments balance.\nFinancialAccounts serve as the source and destination of Treasury’s money movement APIs."
  (
    defstruct [
      :active_features,
      :balance,
      :country,
      :created,
      :features,
      :financial_addresses,
      :id,
      :livemode,
      :metadata,
      :object,
      :pending_features,
      :platform_restrictions,
      :restricted_features,
      :status,
      :status_details,
      :supported_currencies
    ]

    @typedoc "The `treasury.financial_account` type.\n\n  * `active_features` The array of paths to active Features in the Features hash.\n  * `balance` \n  * `country` Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `features` \n  * `financial_addresses` The set of credentials that resolve to a FinancialAccount.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `pending_features` The array of paths to pending Features in the Features hash.\n  * `platform_restrictions` The set of functionalities that the platform can restrict on the FinancialAccount.\n  * `restricted_features` The array of paths to restricted Features in the Features hash.\n  * `status` The enum specifying what state the account is in.\n  * `status_details` \n  * `supported_currencies` The currencies the FinancialAccount can hold a balance in. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase.\n"
    @type t :: %__MODULE__{
            active_features: term,
            balance: term,
            country: binary,
            created: integer,
            features: Stripe.Treasury.FinancialAccountFeatures.t(),
            financial_addresses: term,
            id: binary,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            pending_features: term,
            platform_restrictions: term | nil,
            restricted_features: term,
            status: binary,
            status_details: term,
            supported_currencies: term
          }
  )

  (
    @typedoc "Adds an ABA FinancialAddress to the FinancialAccount."
    @type aba :: %{optional(:requested) => boolean}
  )

  (
    @typedoc "Enables ACH Debits via the InboundTransfers API."
    @type ach :: %{optional(:requested) => boolean}
  )

  (
    @typedoc "Encodes the FinancialAccount's ability to be used with the Issuing product, including attaching cards to and drawing funds from the FinancialAccount."
    @type card_issuing :: %{optional(:requested) => boolean}
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
    @typedoc "Represents whether this FinancialAccount is eligible for deposit insurance. Various factors determine the insurance amount."
    @type deposit_insurance :: %{optional(:requested) => boolean}
  )

  (
    @typedoc "Encodes whether a FinancialAccount has access to a particular feature. Stripe or the platform can control features via the requested field."
    @type features :: %{
            optional(:card_issuing) => card_issuing,
            optional(:deposit_insurance) => deposit_insurance,
            optional(:financial_addresses) => financial_addresses,
            optional(:inbound_transfers) => inbound_transfers,
            optional(:intra_stripe_flows) => intra_stripe_flows,
            optional(:outbound_payments) => outbound_payments,
            optional(:outbound_transfers) => outbound_transfers
          }
  )

  (
    @typedoc "Contains Features that add FinancialAddresses to the FinancialAccount."
    @type financial_addresses :: %{optional(:aba) => aba}
  )

  (
    @typedoc "Contains settings related to adding funds to a FinancialAccount from another Account with the same owner."
    @type inbound_transfers :: %{optional(:ach) => ach}
  )

  (
    @typedoc "Represents the ability for the FinancialAccount to send money to, or receive money from other FinancialAccounts (for example, via OutboundPayment)."
    @type intra_stripe_flows :: %{optional(:requested) => boolean}
  )

  (
    @typedoc "Includes Features related to initiating money movement out of the FinancialAccount to someone else's bucket of money."
    @type outbound_payments :: %{
            optional(:ach) => ach,
            optional(:us_domestic_wire) => us_domestic_wire
          }
  )

  (
    @typedoc "Contains a Feature and settings related to moving money out of the FinancialAccount into another Account with the same owner."
    @type outbound_transfers :: %{
            optional(:ach) => ach,
            optional(:us_domestic_wire) => us_domestic_wire
          }
  )

  (
    @typedoc "The set of functionalities that the platform can restrict on the FinancialAccount."
    @type platform_restrictions :: %{
            optional(:inbound_flows) => :restricted | :unrestricted,
            optional(:outbound_flows) => :restricted | :unrestricted
          }
  )

  (
    @typedoc "Enables US domestic wire transfers via the OutboundPayments API."
    @type us_domestic_wire :: %{optional(:requested) => boolean}
  )

  (
    nil

    @doc "<p>Returns a list of FinancialAccounts.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/financial_accounts`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Treasury.FinancialAccount.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/financial_accounts", [], [])

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

    @doc "<p>Retrieves the details of a FinancialAccount.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/financial_accounts/{financial_account}`\n"
    (
      @spec retrieve(
              financial_account :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.FinancialAccount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(financial_account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/financial_accounts/{financial_account}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "financial_account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "financial_account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [financial_account]
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

    @doc "<p>Retrieves Features information associated with the FinancialAccount.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/treasury/financial_accounts/{financial_account}/features`\n"
    (
      @spec retrieve_features(
              financial_account :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.FinancialAccountFeatures.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve_features(financial_account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/financial_accounts/{financial_account}/features",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "financial_account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "financial_account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [financial_account]
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

    @doc "<p>Creates a new FinancialAccount. For now, each connected account can only have one FinancialAccount.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/financial_accounts`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:features) => features,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:platform_restrictions) => platform_restrictions,
                optional(:supported_currencies) => list(binary)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.FinancialAccount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/treasury/financial_accounts", [], [])

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

    @doc "<p>Updates the details of a FinancialAccount.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/financial_accounts/{financial_account}`\n"
    (
      @spec update(
              financial_account :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:features) => features,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:platform_restrictions) => platform_restrictions
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.FinancialAccount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(financial_account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/financial_accounts/{financial_account}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "financial_account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "financial_account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [financial_account]
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

    @doc "<p>Updates the Features associated with a FinancialAccount.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/treasury/financial_accounts/{financial_account}/features`\n"
    (
      @spec update_features(
              financial_account :: binary(),
              params :: %{
                optional(:card_issuing) => card_issuing,
                optional(:deposit_insurance) => deposit_insurance,
                optional(:expand) => list(binary),
                optional(:financial_addresses) => financial_addresses,
                optional(:inbound_transfers) => inbound_transfers,
                optional(:intra_stripe_flows) => intra_stripe_flows,
                optional(:outbound_payments) => outbound_payments,
                optional(:outbound_transfers) => outbound_transfers
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Treasury.FinancialAccountFeatures.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update_features(financial_account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/treasury/financial_accounts/{financial_account}/features",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "financial_account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "financial_account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [financial_account]
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