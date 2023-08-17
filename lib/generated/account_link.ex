defmodule Stripe.AccountLink do
  use Stripe.Entity

  @moduledoc "Account Links are the means by which a Connect platform grants a connected account permission to access\nStripe-hosted applications, such as Connect Onboarding.\n\nRelated guide: [Connect Onboarding](https://stripe.com/docs/connect/connect-onboarding)"
  (
    defstruct [:created, :expires_at, :object, :url]

    @typedoc "The `account_link` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `expires_at` The timestamp at which this account link will expire.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `url` The URL for the account link.\n"
    @type t :: %__MODULE__{created: integer, expires_at: integer, object: binary, url: binary}
  )

  (
    nil

    @doc "<p>Creates an AccountLink object that includes a single-use Stripe URL that the platform can redirect their user to in order to take them through the Connect Onboarding flow.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/account_links`\n"
    (
      @spec create(
              params :: %{
                optional(:account) => binary,
                optional(:collect) => :currently_due | :eventually_due,
                optional(:expand) => list(binary),
                optional(:refresh_url) => binary,
                optional(:return_url) => binary,
                optional(:type) => :account_onboarding | :account_update
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.AccountLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/account_links", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
