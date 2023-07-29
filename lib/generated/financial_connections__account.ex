defmodule Stripe.FinancialConnections.Account do
  use Stripe.Entity

  @moduledoc "A Financial Connections Account represents an account that exists outside of Stripe, to which you have been granted some degree of access."
  (
    defstruct [
      :account_holder,
      :balance,
      :balance_refresh,
      :category,
      :created,
      :display_name,
      :id,
      :institution_name,
      :last4,
      :livemode,
      :object,
      :ownership,
      :ownership_refresh,
      :permissions,
      :status,
      :subcategory,
      :supported_payment_method_types
    ]

    @typedoc "The `financial_connections.account` type.\n\n  * `account_holder` The account holder that this account belongs to.\n  * `balance` The most recent information about the account's balance.\n  * `balance_refresh` The state of the most recent attempt to refresh the account balance.\n  * `category` The type of the account. Account category is further divided in `subcategory`.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `display_name` A human-readable name that has been assigned to this account, either by the account holder or by the institution.\n  * `id` Unique identifier for the object.\n  * `institution_name` The name of the institution that holds this account.\n  * `last4` The last 4 digits of the account number. If present, this will be 4 numeric characters.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `ownership` The most recent information about the account's owners.\n  * `ownership_refresh` The state of the most recent attempt to refresh the account owners.\n  * `permissions` The list of permissions granted by this account.\n  * `status` The status of the link to the account.\n  * `subcategory` If `category` is `cash`, one of:\n\n - `checking`\n - `savings`\n - `other`\n\nIf `category` is `credit`, one of:\n\n - `mortgage`\n - `line_of_credit`\n - `credit_card`\n - `other`\n\nIf `category` is `investment` or `other`, this will be `other`.\n  * `supported_payment_method_types` The [PaymentMethod type](https://stripe.com/docs/api/payment_methods/object#payment_method_object-type)(s) that can be created from this account.\n"
    @type t :: %__MODULE__{
            account_holder: term | nil,
            balance: term | nil,
            balance_refresh: term | nil,
            category: binary,
            created: integer,
            display_name: binary | nil,
            id: binary,
            institution_name: binary,
            last4: binary | nil,
            livemode: boolean,
            object: binary,
            ownership: (binary | term) | nil,
            ownership_refresh: term | nil,
            permissions: term | nil,
            status: binary,
            subcategory: binary,
            supported_payment_method_types: term
          }
  )

  (
    @typedoc nil
    @type account_holder :: %{optional(:account) => binary, optional(:customer) => binary}
  )

  (
    nil

    @doc "<p>Returns a list of Financial Connections <code>Account</code> objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/financial_connections/accounts`\n"
    (
      @spec list(
              params :: %{
                optional(:account_holder) => account_holder,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:session) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.FinancialConnections.Account.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/financial_connections/accounts", [], [])

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

    @doc "<p>Retrieves the details of an Financial Connections <code>Account</code>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/financial_connections/accounts/{account}`\n"
    (
      @spec retrieve(
              account :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.FinancialConnections.Account.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/financial_connections/accounts/{account}",
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

    @doc "<p>Lists all owners for a given <code>Account</code></p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/financial_connections/accounts/{account}/owners`\n"
    (
      @spec list_owners(
              account :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:ownership) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.FinancialConnections.AccountOwner.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list_owners(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/financial_connections/accounts/{account}/owners",
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

    @doc "<p>Refreshes the data associated with a Financial Connections <code>Account</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/financial_connections/accounts/{account}/refresh`\n"
    (
      @spec refresh(
              account :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:features) => list(:balance | :ownership)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.FinancialConnections.Account.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def refresh(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/financial_connections/accounts/{account}/refresh",
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

  (
    nil

    @doc "<p>Disables your access to a Financial Connections <code>Account</code>. You will no longer be able to access data associated with the account (e.g. balances, transactions).</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/financial_connections/accounts/{account}/disconnect`\n"
    (
      @spec disconnect(
              account :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.FinancialConnections.Account.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def disconnect(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/financial_connections/accounts/{account}/disconnect",
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
