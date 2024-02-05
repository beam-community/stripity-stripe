defmodule Stripe.EphemeralKey do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [:created, :expires, :id, :livemode, :object, :secret]

    @typedoc "The `ephemeral_key` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `expires` Time at which the key will expire. Measured in seconds since the Unix epoch.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `secret` The key's secret. You can use this value to make authorized requests to the Stripe API.\n"
    @type t :: %__MODULE__{
            created: integer,
            expires: integer,
            id: binary,
            livemode: boolean,
            object: binary,
            secret: binary
          }
  )

  (
    nil

    @doc "<p>Invalidates a short-lived API key for a given resource.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/ephemeral_keys/{key}`\n"
    (
      @spec delete(
              key :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.EphemeralKey.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete(key, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/ephemeral_keys/{key}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "key",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "key",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [key]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Creates a short-lived API key for a given resource.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/ephemeral_keys`\n"
    (
      @spec create(
              params :: %{
                optional(:customer) => binary,
                optional(:expand) => list(binary),
                optional(:issuing_card) => binary,
                optional(:nonce) => binary,
                optional(:verification_session) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.EphemeralKey.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/ephemeral_keys", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
