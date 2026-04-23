# credo:disable-for-this-file
defmodule Stripe.Billing.CreditGrant do
  use Stripe.Entity

  @moduledoc "A credit grant is an API resource that documents the allocation of some billing credits to a customer.\n\nRelated guide: [Billing credits](https://docs.stripe.com/billing/subscriptions/usage-based/billing-credits)"
  (
    defstruct [
      :amount,
      :applicability_config,
      :category,
      :created,
      :customer,
      :effective_at,
      :expires_at,
      :id,
      :livemode,
      :metadata,
      :name,
      :object,
      :priority,
      :test_clock,
      :updated,
      :voided_at
    ]

    @typedoc "The `billing.credit_grant` type.\n\n  * `amount` \n  * `applicability_config` \n  * `category` The category of this credit grant. This is for tracking purposes and isn't displayed to the customer.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` ID of the customer receiving the billing credits.\n  * `effective_at` The time when the billing credits become effective-when they're eligible for use.\n  * `expires_at` The time when the billing credits expire. If not present, the billing credits don't expire.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` A descriptive name shown in dashboard.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `priority` The priority for applying this credit grant. The highest priority is 0 and the lowest is 100.\n  * `test_clock` ID of the test clock this credit grant belongs to.\n  * `updated` Time at which the object was last updated. Measured in seconds since the Unix epoch.\n  * `voided_at` The time when this credit grant was voided. If not present, the credit grant hasn't been voided.\n"
    @type t :: %__MODULE__{
            amount: term,
            applicability_config: term,
            category: binary,
            created: integer,
            customer: binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t(),
            effective_at: integer | nil,
            expires_at: integer | nil,
            id: binary,
            livemode: boolean,
            metadata: term,
            name: binary | nil,
            object: binary,
            priority: integer | nil,
            test_clock: (binary | Stripe.TestHelpers.TestClock.t()) | nil,
            updated: integer,
            voided_at: integer | nil
          }
  )

  (
    @typedoc "Amount of this credit grant."
    @type amount :: %{optional(:monetary) => monetary, optional(:type) => :monetary}
  )

  (
    @typedoc "Configuration specifying what this credit grant applies to. We currently only support `metered` prices that have a [Billing Meter](https://docs.stripe.com/api/billing/meter) attached to them."
    @type applicability_config :: %{optional(:scope) => scope}
  )

  (
    @typedoc "The monetary amount."
    @type monetary :: %{optional(:currency) => binary, optional(:value) => integer}
  )

  (
    @typedoc nil
    @type prices :: %{optional(:id) => binary}
  )

  (
    @typedoc "Specify the scope of this applicability config."
    @type scope :: %{optional(:price_type) => :metered, optional(:prices) => list(prices)}
  )

  (
    nil

    @doc "<p>Retrieve a list of credit grants.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/credit_grants`\n"
    (
      @spec list(
              params :: %{
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Billing.CreditGrant.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing/credit_grants", [], [])

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

    @doc "<p>Retrieves a credit grant.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/credit_grants/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.CreditGrant.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/credit_grants/{id}",
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

    @doc "<p>Creates a credit grant.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/credit_grants`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => amount,
                optional(:applicability_config) => applicability_config,
                optional(:category) => :paid | :promotional,
                optional(:customer) => binary,
                optional(:effective_at) => integer,
                optional(:expand) => list(binary),
                optional(:expires_at) => integer,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary,
                optional(:priority) => integer
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.CreditGrant.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing/credit_grants", [], [])

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

    @doc "<p>Updates a credit grant.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/credit_grants/{id}`\n"
    (
      @spec update(
              id :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:expires_at) => integer | binary,
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.CreditGrant.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/credit_grants/{id}",
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

    @doc "<p>Expires a credit grant.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/credit_grants/{id}/expire`\n"
    (
      @spec expire(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.CreditGrant.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def expire(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/credit_grants/{id}/expire",
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

    @doc "<p>Voids a credit grant.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/credit_grants/{id}/void`\n"
    (
      @spec void_grant(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.CreditGrant.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def void_grant(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/credit_grants/{id}/void",
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