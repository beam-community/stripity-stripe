defmodule Stripe.Transfer do
  use Stripe.Entity

  @moduledoc "A `Transfer` object is created when you move funds between Stripe accounts as\npart of Connect.\n\nBefore April 6, 2017, transfers also represented movement of funds from a\nStripe account to a card or bank account. This behavior has since been split\nout into a [Payout](https://stripe.com/docs/api#payout_object) object, with corresponding payout endpoints. For more\ninformation, read about the\n[transfer/payout split](https://stripe.com/docs/transfer-payout-split).\n\nRelated guide: [Creating separate charges and transfers](https://stripe.com/docs/connect/separate-charges-and-transfers)"
  (
    defstruct [
      :amount,
      :amount_reversed,
      :balance_transaction,
      :created,
      :currency,
      :description,
      :destination,
      :destination_payment,
      :id,
      :livemode,
      :metadata,
      :object,
      :reversals,
      :reversed,
      :source_transaction,
      :source_type,
      :transfer_group
    ]

    @typedoc "The `transfer` type.\n\n  * `amount` Amount in cents (or local equivalent) to be transferred.\n  * `amount_reversed` Amount in cents (or local equivalent) reversed (can be less than the amount attribute on the transfer if a partial reversal was issued).\n  * `balance_transaction` Balance transaction that describes the impact of this transfer on your account balance.\n  * `created` Time that this record of the transfer was first created.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `destination` ID of the Stripe account the transfer was sent to.\n  * `destination_payment` If the destination is a Stripe account, this will be the ID of the payment that the destination account received for the transfer.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `reversals` A list of reversals that have been applied to the transfer.\n  * `reversed` Whether the transfer has been fully reversed. If the transfer is only partially reversed, this attribute will still be false.\n  * `source_transaction` ID of the charge that was used to fund the transfer. If null, the transfer was funded from the available balance.\n  * `source_type` The source balance this transfer came from. One of `card`, `fpx`, or `bank_account`.\n  * `transfer_group` A string that identifies this transaction as part of a group. See the [Connect documentation](https://stripe.com/docs/connect/separate-charges-and-transfers#transfer-options) for details.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_reversed: integer,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            created: integer,
            currency: binary,
            description: binary | nil,
            destination: (binary | Stripe.Account.t()) | nil,
            destination_payment: binary | Stripe.Charge.t(),
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
            reversals: term,
            reversed: boolean,
            source_transaction: (binary | Stripe.Charge.t()) | nil,
            source_type: binary,
            transfer_group: binary | nil
          }
  )

  (
    @typedoc nil
    @type created :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    nil

    @doc "<p>Returns a list of existing transfers sent to connected accounts. The transfers are returned in sorted order, with the most recently created transfers appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/transfers`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:destination) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:transfer_group) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Transfer.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/transfers", [], [])

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

    @doc "<p>Retrieves the details of an existing transfer. Supply the unique transfer ID from either a transfer creation request or the transfer list, and Stripe will return the corresponding transfer information.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/transfers/{transfer}`\n"
    (
      @spec retrieve(
              transfer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Transfer.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/transfers/{transfer}",
            [
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
            [transfer]
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

    @doc "<p>To send funds from your Stripe account to a connected account, you create a new transfer object. Your <a href=\"#balance\">Stripe balance</a> must be able to cover the transfer amount, or you’ll receive an “Insufficient Funds” error.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/transfers`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:description) => binary,
                optional(:destination) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:source_transaction) => binary,
                optional(:source_type) => :bank_account | :card | :fpx,
                optional(:transfer_group) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Transfer.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/transfers", [], [])

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

    @doc "<p>Updates the specified transfer by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n<p>This request accepts only metadata as an argument.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/transfers/{transfer}`\n"
    (
      @spec update(
              transfer :: binary(),
              params :: %{
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Transfer.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(transfer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/transfers/{transfer}",
            [
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
            [transfer]
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