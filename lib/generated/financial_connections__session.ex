defmodule Stripe.FinancialConnections.Session do
  use Stripe.Entity

  @moduledoc "A Financial Connections Session is the secure way to programmatically launch the client-side Stripe.js modal that lets your users link their accounts."
  (
    defstruct [
      :account_holder,
      :accounts,
      :client_secret,
      :filters,
      :id,
      :livemode,
      :object,
      :permissions,
      :return_url
    ]

    @typedoc "The `financial_connections.session` type.\n\n  * `account_holder` The account holder for whom accounts are collected in this session.\n  * `accounts` The accounts that were collected as part of this Session.\n  * `client_secret` A value that will be passed to the client to launch the authentication flow.\n  * `filters` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `permissions` Permissions requested for accounts collected during this session.\n  * `return_url` For webview integrations only. Upon completing OAuth login in the native browser, the user will be redirected to this URL to return to your app.\n"
    @type t :: %__MODULE__{
            account_holder: term | nil,
            accounts: term,
            client_secret: binary,
            filters: term,
            id: binary,
            livemode: boolean,
            object: binary,
            permissions: term,
            return_url: binary
          }
  )

  (
    @typedoc "The account holder to link accounts for."
    @type account_holder :: %{
            optional(:account) => binary,
            optional(:customer) => binary,
            optional(:type) => :account | :customer
          }
  )

  (
    @typedoc "Filters to restrict the kinds of accounts to collect."
    @type filters :: %{optional(:countries) => list(binary)}
  )

  (
    nil

    @doc "<p>To launch the Financial Connections authorization flow, create a <code>Session</code>. The session’s <code>client_secret</code> can be used to launch the flow using Stripe.js.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/financial_connections/sessions`\n"
    (
      @spec create(
              params :: %{
                optional(:account_holder) => account_holder,
                optional(:expand) => list(binary),
                optional(:filters) => filters,
                optional(:permissions) =>
                  list(:balances | :ownership | :payment_method | :transactions),
                optional(:return_url) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.FinancialConnections.Session.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/financial_connections/sessions", [], [])

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

    @doc "<p>Retrieves the details of a Financial Connections <code>Session</code></p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/financial_connections/sessions/{session}`\n"
    (
      @spec retrieve(
              session :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.FinancialConnections.Session.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/financial_connections/sessions/{session}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
