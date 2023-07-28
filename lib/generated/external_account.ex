defmodule Stripe.ExternalAccount do
  use Stripe.Entity
  @moduledoc nil
  (
    defstruct []
    @typedoc "The `external_account` type.\n\n\n"
    @type t :: %__MODULE__{}
  )

  (
    @typedoc "One or more documents that support the [Bank account ownership verification](https://support.stripe.com/questions/bank-account-ownership-verification) requirement. Must be a document associated with the bank account that displays the last 4 digits of the account number, either a statement or a voided check."
    @type bank_account_ownership_verification :: %{optional(:files) => list(binary)}
  )

  (
    @typedoc "Documents that may be submitted to satisfy various informational requests."
    @type documents :: %{
            optional(:bank_account_ownership_verification) => bank_account_ownership_verification
          }
  )

  (
    nil

    @doc "<p>List external accounts for an account.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/accounts/{account}/external_accounts`\n"
    (
      @spec list(
              account :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.ExternalAccount.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/external_accounts",
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

    @doc "<p>Retrieve a specified external account for a given account.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/accounts/{account}/external_accounts/{id}`\n"
    (
      @spec retrieve(
              account :: binary(),
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ExternalAccount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(account, id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/external_accounts/{id}",
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
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, id]
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

    @doc "<p>Create an external account for a given account.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/accounts/{account}/external_accounts`\n"
    (
      @spec create(
              account :: binary(),
              params :: %{
                optional(:default_for_currency) => boolean,
                optional(:expand) => list(binary),
                optional(:external_account) => binary,
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ExternalAccount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/external_accounts",
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

    @doc "<p>Updates the metadata, account holder name, account holder type of a bank account belonging to a <a href=\"/docs/connect/custom-accounts\">Custom account</a>, and optionally sets it as the default for its currency. Other bank account details are not editable by design.</p>\n\n<p>You can re-enable a disabled bank account by performing an update call without providing any arguments or changes.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/accounts/{account}/external_accounts/{id}`\n"
    (
      @spec update(
              account :: binary(),
              id :: binary(),
              params :: %{
                optional(:account_holder_name) => binary,
                optional(:account_holder_type) => :company | :individual,
                optional(:account_type) => :checking | :futsu | :savings | :toza,
                optional(:address_city) => binary,
                optional(:address_country) => binary,
                optional(:address_line1) => binary,
                optional(:address_line2) => binary,
                optional(:address_state) => binary,
                optional(:address_zip) => binary,
                optional(:default_for_currency) => boolean,
                optional(:documents) => documents,
                optional(:exp_month) => binary,
                optional(:exp_year) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:name) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ExternalAccount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(account, id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/external_accounts/{id}",
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
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, id]
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

    @doc "<p>Delete a specified external account for a given account.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/accounts/{account}/external_accounts/{id}`\n"
    (
      @spec delete(account :: binary(), id :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedExternalAccount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(account, id, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/external_accounts/{id}",
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
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, id]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end