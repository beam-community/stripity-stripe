defmodule Stripe.ApplePayDomain do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [:created, :domain_name, :id, :livemode, :object]

    @typedoc "The `apple_pay_domain` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `domain_name` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            created: integer,
            domain_name: binary,
            id: binary,
            livemode: boolean,
            object: binary
          }
  )

  (
    nil

    @doc "<p>Delete an apple pay domain.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/apple_pay/domains/{domain}`\n"
    (
      @spec delete(domain :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedApplePayDomain.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(domain, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/apple_pay/domains/{domain}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "domain",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "domain",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [domain]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>List apple pay domains.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/apple_pay/domains`\n"
    (
      @spec list(
              params :: %{
                optional(:domain_name) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.ApplePayDomain.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/apple_pay/domains", [], [])

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

    @doc "<p>Retrieve an apple pay domain.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/apple_pay/domains/{domain}`\n"
    (
      @spec retrieve(
              domain :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ApplePayDomain.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(domain, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/apple_pay/domains/{domain}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "domain",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "domain",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [domain]
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

    @doc "<p>Create an apple pay domain.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/apple_pay/domains`\n"
    (
      @spec create(
              params :: %{optional(:domain_name) => binary, optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ApplePayDomain.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/apple_pay/domains", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end