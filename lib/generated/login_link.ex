defmodule Stripe.LoginLink do
  use Stripe.Entity

  @moduledoc "Login Links are single-use URLs that takes an Express account to the login page for their Stripe dashboard.\nA Login Link differs from an [Account Link](https://stripe.com/docs/api/account_links) in that it takes the user directly to their [Express dashboard for the specified account](https://stripe.com/docs/connect/integrate-express-dashboard#create-login-link)"
  (
    defstruct [:created, :object, :url]

    @typedoc "The `login_link` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `url` The URL for the login link.\n"
    @type t :: %__MODULE__{created: integer, object: binary, url: binary}
  )

  (
    nil

    @doc "<p>Creates a login link for a connected account to access the Express Dashboard.</p>\n\n<p><strong>You can only create login links for accounts that use the <a href=\"/connect/express-dashboard\">Express Dashboard</a> and are connected to your platform</strong>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/accounts/{account}/login_links`\n"
    (
      @spec create(
              account :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.LoginLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/login_links",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "account",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "account",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [account]
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