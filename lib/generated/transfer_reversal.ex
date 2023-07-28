defmodule Stripe.TransferReversal do
  use Stripe.Entity

  @moduledoc "[Stripe Connect](https://stripe.com/docs/connect) platforms can reverse transfers made to a\nconnected account, either entirely or partially, and can also specify whether\nto refund any related application fees. Transfer reversals add to the\nplatform's balance and subtract from the destination account's balance.\n\nReversing a transfer that was made for a [destination\ncharge](/docs/connect/destination-charges) is allowed only up to the amount of\nthe charge. It is possible to reverse a\n[transfer_group](https://stripe.com/docs/connect/separate-charges-and-transfers#transfer-options)\ntransfer only if the destination account has enough balance to cover the\nreversal.\n\nRelated guide: [Reversing transfers](https://stripe.com/docs/connect/separate-charges-and-transfers#reversing-transfers)"
  (
    defstruct [
      :amount,
      :balance_transaction,
      :created,
      :currency,
      :destination_payment_refund,
      :id,
      :metadata,
      :object,
      :source_refund,
      :transfer
    ]

    @typedoc "The `transfer_reversal` type.\n\n  * `amount` Amount, in %s.\n  * `balance_transaction` Balance transaction that describes the impact on your account balance.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `destination_payment_refund` Linked payment refund for the transfer reversal.\n  * `id` Unique identifier for the object.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `source_refund` ID of the refund responsible for the transfer reversal.\n  * `transfer` ID of the transfer that was reversed.\n"
    @type t :: %__MODULE__{
            amount: integer,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            created: integer,
            currency: binary,
            destination_payment_refund: (binary | Stripe.Refund.t()) | nil,
            id: binary,
            metadata: term | nil,
            object: binary,
            source_refund: (binary | Stripe.Refund.t()) | nil,
            transfer: binary | Stripe.Transfer.t()
          }
  )

  (
    nil

    @doc "<p>When you create a new reversal, you must specify a transfer to create it on.</p>\n\n<p>When reversing transfers, you can optionally reverse part of the transfer. You can do so as many times as you wish until the entire transfer has been reversed.</p>\n\n<p>Once entirely reversed, a transfer can’t be reversed again. This method will return an error when called on an already-reversed transfer, or when trying to reverse more money than is left on a transfer.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/transfers/{id}/reversals`\n"
    (
      @spec create(
              id :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:refund_application_fee) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.TransferReversal.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/transfers/{id}/reversals",
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

    @doc "<p>You can see a list of the reversals belonging to a specific transfer. Note that the 10 most recent reversals are always available by default on the transfer object. If you need more than those 10, you can use this API method and the <code>limit</code> and <code>starting_after</code> parameters to page through additional reversals.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/transfers/{id}/reversals`\n"
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
              {:ok, Stripe.List.t(Stripe.TransferReversal.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/transfers/{id}/reversals",
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

    @doc "<p>By default, you can see the 10 most recent reversals stored directly on the transfer object, but you can also retrieve details about a specific reversal stored on the transfer.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/transfers/{transfer}/reversals/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              transfer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.TransferReversal.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/transfers/{transfer}/reversals/{id}",
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
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [id, transfer]
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

    @doc "<p>Updates the specified reversal by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n<p>This request only accepts metadata and description as arguments.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/transfers/{transfer}/reversals/{id}`\n"
    (
      @spec update(
              id :: binary(),
              transfer :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.TransferReversal.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(id, transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/transfers/{transfer}/reversals/{id}",
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
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transfer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transfer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [id, transfer]
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