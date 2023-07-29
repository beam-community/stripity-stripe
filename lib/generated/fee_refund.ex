defmodule Stripe.FeeRefund do
  use Stripe.Entity

  @moduledoc "`Application Fee Refund` objects allow you to refund an application fee that\nhas previously been created but not yet refunded. Funds will be refunded to\nthe Stripe account from which the fee was originally collected.\n\nRelated guide: [Refunding application fees](https://stripe.com/docs/connect/destination-charges#refunding-app-fee)"
  (
    defstruct [:amount, :balance_transaction, :created, :currency, :fee, :id, :metadata, :object]

    @typedoc "The `fee_refund` type.\n\n  * `amount` Amount, in %s.\n  * `balance_transaction` Balance transaction that describes the impact on your account balance.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `fee` ID of the application fee that was refunded.\n  * `id` Unique identifier for the object.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            amount: integer,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            created: integer,
            currency: binary,
            fee: binary | Stripe.ApplicationFee.t(),
            id: binary,
            metadata: term | nil,
            object: binary
          }
  )

  (
    nil

    @doc "<p>Refunds an application fee that has previously been collected but not yet refunded.\nFunds will be refunded to the Stripe account from which the fee was originally collected.</p>\n\n<p>You can optionally refund only part of an application fee.\nYou can do so multiple times, until the entire fee has been refunded.</p>\n\n<p>Once entirely refunded, an application fee can’t be refunded again.\nThis method will raise an error when called on an already-refunded application fee,\nor when trying to refund more money than is left on an application fee.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/application_fees/{id}/refunds`\n"
    (
      @spec create(
              id :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.FeeRefund.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/application_fees/{id}/refunds",
            [
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
            [id]
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

    @doc "<p>You can see a list of the refunds belonging to a specific application fee. Note that the 10 most recent refunds are always available by default on the application fee object. If you need more than those 10, you can use this API method and the <code>limit</code> and <code>starting_after</code> parameters to page through additional refunds.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/application_fees/{id}/refunds`\n"
    (
      @spec list(
              id :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.FeeRefund.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/application_fees/{id}/refunds",
            [
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
            [id]
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

    @doc "<p>By default, you can see the 10 most recent refunds stored directly on the application fee object, but you can also retrieve details about a specific refund stored on the application fee.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/application_fees/{fee}/refunds/{id}`\n"
    (
      @spec retrieve(
              fee :: binary(),
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.FeeRefund.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(fee, id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/application_fees/{fee}/refunds/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "fee",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "fee",
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
            [fee, id]
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

    @doc "<p>Updates the specified application fee refund by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n<p>This request only accepts metadata as an argument.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/application_fees/{fee}/refunds/{id}`\n"
    (
      @spec update(
              fee :: binary(),
              id :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.FeeRefund.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(fee, id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/application_fees/{fee}/refunds/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "fee",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "fee",
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
            [fee, id]
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
