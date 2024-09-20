defmodule Stripe.Capability do
  use Stripe.Entity

  @moduledoc "This is an object representing a capability for a Stripe account.\n\nRelated guide: [Account capabilities](https://stripe.com/docs/connect/account-capabilities)"
  (
    defstruct [
      :account,
      :future_requirements,
      :id,
      :object,
      :requested,
      :requested_at,
      :requirements,
      :status
    ]

    @typedoc "The `capability` type.\n\n  * `account` The account for which the capability enables functionality.\n  * `future_requirements` \n  * `id` The identifier for the capability.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `requested` Whether the capability has been requested.\n  * `requested_at` Time at which the capability was requested. Measured in seconds since the Unix epoch.\n  * `requirements` \n  * `status` The status of the capability. Can be `active`, `inactive`, `pending`, or `unrequested`.\n"
    @type t :: %__MODULE__{
            account: binary | Stripe.Account.t(),
            future_requirements: term,
            id: binary,
            object: binary,
            requested: boolean,
            requested_at: integer | nil,
            requirements: term,
            status: binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of capabilities associated with the account. The capabilities are returned sorted by creation date, with the most recent capability appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/accounts/{account}/capabilities`\n"
    (
      @spec list(
              account :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Capability.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/capabilities",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account]
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

    @doc "<p>Retrieves information about the specified Account Capability.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/accounts/{account}/capabilities/{capability}`\n"
    (
      @spec retrieve(
              account :: binary(),
              capability :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Capability.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(account, capability, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/capabilities/{capability}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "capability",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "capability",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, capability]
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

    @doc "<p>Updates an existing Account Capability. Request or remove a capability by updating its <code>requested</code> parameter.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/accounts/{account}/capabilities/{capability}`\n"
    (
      @spec update(
              account :: binary(),
              capability :: binary(),
              params :: %{optional(:expand) => list(binary), optional(:requested) => boolean},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Capability.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(account, capability, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/capabilities/{capability}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "capability",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "capability",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, capability]
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
