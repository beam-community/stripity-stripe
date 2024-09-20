defmodule Stripe.Issuing.Token do
  use Stripe.Entity

  @moduledoc "An issuing token object is created when an issued card is added to a digital wallet. As a [card issuer](https://stripe.com/docs/issuing), you can [view and manage these tokens](https://stripe.com/docs/issuing/controls/token-management) through Stripe."
  (
    defstruct [
      :card,
      :created,
      :device_fingerprint,
      :id,
      :last4,
      :livemode,
      :network,
      :network_data,
      :network_updated_at,
      :object,
      :status,
      :wallet_provider
    ]

    @typedoc "The `issuing.token` type.\n\n  * `card` Card associated with this token.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `device_fingerprint` The hashed ID derived from the device ID from the card network associated with the token.\n  * `id` Unique identifier for the object.\n  * `last4` The last four digits of the token.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `network` The token service provider / card network associated with the token.\n  * `network_data` \n  * `network_updated_at` Time at which the token was last updated by the card network. Measured in seconds since the Unix epoch.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` The usage state of the token.\n  * `wallet_provider` The digital wallet for this token, if one was used.\n"
    @type t :: %__MODULE__{
            card: binary | Stripe.Issuing.Card.t(),
            created: integer,
            device_fingerprint: binary | nil,
            id: binary,
            last4: binary,
            livemode: boolean,
            network: binary,
            network_data: term,
            network_updated_at: integer,
            object: binary,
            status: binary,
            wallet_provider: binary
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

    @doc "<p>Lists all Issuing <code>Token</code> objects for a given card.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/tokens`\n"
    (
      @spec list(
              params :: %{
                optional(:card) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :active | :deleted | :requested | :suspended
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.Token.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/tokens", [], [])

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

    @doc "<p>Retrieves an Issuing <code>Token</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/tokens/{token}`\n"
    (
      @spec retrieve(
              token :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Token.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(token, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/tokens/{token}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "token",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "token",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [token]
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

    @doc "<p>Attempts to update the specified Issuing <code>Token</code> object to the status specified.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/tokens/{token}`\n"
    (
      @spec update(
              token :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:status) => :active | :deleted | :suspended
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Token.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(token, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/tokens/{token}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "token",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "token",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [token]
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
