defmodule Stripe.LoginLink do
  use Stripe.Entity

  @moduledoc "Login Links are single-use login link for an Express account to access their Stripe dashboard."
  (
    defstruct [:created, :object, :url]

    @typedoc "The `login_link` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `url` The URL for the login link.\n"
    @type t :: %__MODULE__{created: integer, object: binary, url: binary}
  )

  (
    nil

    @doc "<p>Creates a single-use login link for an Express account to access their Stripe dashboard.</p>\n\n<p><strong>You may only create login links for <a href=\"/docs/connect/express-accounts\">Express accounts</a> connected to your platform</strong>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/accounts/{account}/login_links`\n"
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end