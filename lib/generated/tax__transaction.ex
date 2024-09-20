defmodule Stripe.Tax.Transaction do
  use Stripe.Entity

  @moduledoc "A Tax Transaction records the tax collected from or refunded to your customer.\n\nRelated guide: [Calculate tax in your custom payment flow](https://stripe.com/docs/tax/custom#tax-transaction)"
  (
    defstruct [
      :created,
      :currency,
      :customer,
      :customer_details,
      :id,
      :line_items,
      :livemode,
      :metadata,
      :object,
      :posted_at,
      :reference,
      :reversal,
      :ship_from_details,
      :shipping_cost,
      :tax_date,
      :type
    ]

    @typedoc "The `tax.transaction` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` The ID of an existing [Customer](https://stripe.com/docs/api/customers/object) used for the resource.\n  * `customer_details` \n  * `id` Unique identifier for the transaction.\n  * `line_items` The tax collected or refunded, by line item.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `posted_at` The Unix timestamp representing when the tax liability is assumed or reduced.\n  * `reference` A custom unique identifier, such as 'myOrder_123'.\n  * `reversal` If `type=reversal`, contains information about what was reversed.\n  * `ship_from_details` The details of the ship from location, such as the address.\n  * `shipping_cost` The shipping cost details for the transaction.\n  * `tax_date` Timestamp of date at which the tax rules and rates in effect applies for the calculation.\n  * `type` If `reversal`, this transaction reverses an earlier transaction.\n"
    @type t :: %__MODULE__{
            created: integer,
            currency: binary,
            customer: binary | nil,
            customer_details: term,
            id: binary,
            line_items: term | nil,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            posted_at: integer,
            reference: binary,
            reversal: term | nil,
            ship_from_details: term | nil,
            shipping_cost: term | nil,
            tax_date: integer,
            type: binary
          }
  )

  (
    @typedoc nil
    @type line_items :: %{
            optional(:amount) => integer,
            optional(:amount_tax) => integer,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:original_line_item) => binary,
            optional(:quantity) => integer,
            optional(:reference) => binary
          }
  )

  (
    @typedoc "The shipping cost to reverse."
    @type shipping_cost :: %{optional(:amount) => integer, optional(:amount_tax) => integer}
  )

  (
    nil

    @doc "<p>Retrieves a Tax <code>Transaction</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax/transactions/{transaction}`\n"
    (
      @spec retrieve(
              transaction :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax/transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
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

    @doc "<p>Retrieves the line items of a committed standalone transaction as a collection.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax/transactions/{transaction}/line_items`\n"
    (
      @spec list_line_items(
              transaction :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Tax.TransactionLineItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list_line_items(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax/transactions/{transaction}/line_items",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
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

    @doc "<p>Creates a Tax Transaction from a calculation, if that calculation hasn’t expired. Calculations expire after 90 days.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax/transactions/create_from_calculation`\n"
    (
      @spec create_from_calculation(
              params :: %{
                optional(:calculation) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:posted_at) => integer,
                optional(:reference) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create_from_calculation(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax/transactions/create_from_calculation",
            [],
            []
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

    @doc "<p>Partially or fully reverses a previously created <code>Transaction</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax/transactions/create_reversal`\n"
    (
      @spec create_reversal(
              params :: %{
                optional(:expand) => list(binary),
                optional(:flat_amount) => integer,
                optional(:line_items) => list(line_items),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:mode) => :full | :partial,
                optional(:original_transaction) => binary,
                optional(:reference) => binary,
                optional(:shipping_cost) => shipping_cost
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create_reversal(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/tax/transactions/create_reversal", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end