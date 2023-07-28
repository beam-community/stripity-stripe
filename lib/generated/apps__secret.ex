defmodule Stripe.Apps.Secret do
  use Stripe.Entity

  @moduledoc "Secret Store is an API that allows Stripe Apps developers to securely persist secrets for use by UI Extensions and app backends.\n\nThe primary resource in Secret Store is a `secret`. Other apps can't view secrets created by an app. Additionally, secrets are scoped to provide further permission control.\n\nAll Dashboard users and the app backend share `account` scoped secrets. Use the `account` scope for secrets that don't change per-user, like a third-party API key.\n\nA `user` scoped secret is accessible by the app backend and one specific Dashboard user. Use the `user` scope for per-user secrets like per-user OAuth tokens, where different users might have different permissions.\n\nRelated guide: [Store data between page reloads](https://stripe.com/docs/stripe-apps/store-auth-data-custom-objects)"
  (
    defstruct [:created, :deleted, :expires_at, :id, :livemode, :name, :object, :payload, :scope]

    @typedoc "The `apps.secret` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `deleted` If true, indicates that this secret has been deleted\n  * `expires_at` The Unix timestamp for the expiry time of the secret, after which the secret deletes.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `name` A name for the secret that's unique within the scope.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payload` The plaintext secret value to be stored.\n  * `scope` \n"
    @type t :: %__MODULE__{
            created: integer,
            deleted: boolean,
            expires_at: integer | nil,
            id: binary,
            livemode: boolean,
            name: binary,
            object: binary,
            payload: binary | nil,
            scope: term
          }
  )

  (
    @typedoc nil
    @type scope :: %{optional(:type) => :account | :user, optional(:user) => binary}
  )

  (
    nil

    @doc "<p>Finds a secret in the secret store by name and scope.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/apps/secrets/find`\n"
    (
      @spec find(
              params :: %{
                optional(:expand) => list(binary),
                optional(:name) => binary,
                optional(:scope) => scope
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Apps.Secret.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def find(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/apps/secrets/find", [], [])

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

    @doc "<p>Create or replace a secret in the secret store.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/apps/secrets`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:expires_at) => integer,
                optional(:name) => binary,
                optional(:payload) => binary,
                optional(:scope) => scope
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Apps.Secret.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/apps/secrets", [], [])

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

    @doc "<p>Deletes a secret from the secret store by name and scope.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/apps/secrets/delete`\n"
    (
      @spec delete_where(
              params :: %{
                optional(:expand) => list(binary),
                optional(:name) => binary,
                optional(:scope) => scope
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Apps.Secret.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete_where(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/apps/secrets/delete", [], [])

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

    @doc "<p>List all secrets stored on the given scope.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/apps/secrets`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:scope) => scope,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Apps.Secret.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/apps/secrets", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end