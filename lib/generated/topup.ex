defmodule Stripe.Topup do
  use Stripe.Entity

  @moduledoc "To top up your Stripe balance, you create a top-up object. You can retrieve\nindividual top-ups, as well as list all top-ups. Top-ups are identified by a\nunique, random ID.\n\nRelated guide: [Topping up your platform account](https://stripe.com/docs/connect/top-ups)"
  (
    defstruct [
      :amount,
      :balance_transaction,
      :created,
      :currency,
      :description,
      :expected_availability_date,
      :failure_code,
      :failure_message,
      :id,
      :livemode,
      :metadata,
      :object,
      :source,
      :statement_descriptor,
      :status,
      :transfer_group
    ]

    @typedoc "The `topup` type.\n\n  * `amount` Amount transferred.\n  * `balance_transaction` ID of the balance transaction that describes the impact of this top-up on your account balance. May not be specified depending on status of top-up.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `expected_availability_date` Date the funds are expected to arrive in your Stripe account for payouts. This factors in delays like weekends or bank holidays. May not be specified depending on status of top-up.\n  * `failure_code` Error code explaining reason for top-up failure if available (see [the errors section](https://stripe.com/docs/api#errors) for a list of codes).\n  * `failure_message` Message to user further explaining reason for top-up failure if available.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `source` The source field is deprecated. It might not always be present in the API response.\n  * `statement_descriptor` Extra information about a top-up. This will appear on your source's bank statement. It must contain at least one letter.\n  * `status` The status of the top-up is either `canceled`, `failed`, `pending`, `reversed`, or `succeeded`.\n  * `transfer_group` A string that identifies this top-up as part of a group.\n"
    @type t :: %__MODULE__{
            amount: integer,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            created: integer,
            currency: binary,
            description: binary | nil,
            expected_availability_date: integer | nil,
            failure_code: binary | nil,
            failure_message: binary | nil,
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
            source: Stripe.Source.t() | nil,
            statement_descriptor: binary | nil,
            status: binary,
            transfer_group: binary | nil
          }
  )

  (
    @typedoc nil
    @type amount :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
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

    @doc "<p>Returns a list of top-ups.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/topups`\n"
    (
      @spec list(
              params :: %{
                optional(:amount) => amount | integer,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :canceled | :failed | :pending | :succeeded
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Topup.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/topups", [], [])

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

    @doc "<p>Retrieves the details of a top-up that has previously been created. Supply the unique top-up ID that was returned from your previous request, and Stripe will return the corresponding top-up information.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/topups/{topup}`\n"
    (
      @spec retrieve(
              topup :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Topup.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(topup, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/topups/{topup}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "topup",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "topup",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [topup]
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

    @doc "<p>Top up the balance of an account</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/topups`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:source) => binary,
                optional(:statement_descriptor) => binary,
                optional(:transfer_group) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Topup.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/topups", [], [])

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

    @doc "<p>Updates the metadata of a top-up. Other top-up details are not editable by design.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/topups/{topup}`\n"
    (
      @spec update(
              topup :: binary(),
              params :: %{
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Topup.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(topup, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/topups/{topup}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "topup",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "topup",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [topup]
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

    @doc "<p>Cancels a top-up. Only pending top-ups can be canceled.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/topups/{topup}/cancel`\n"
    (
      @spec cancel(
              topup :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Topup.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def cancel(topup, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/topups/{topup}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "topup",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "topup",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [topup]
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
