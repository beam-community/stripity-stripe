defmodule Stripe.Issuing.Dispute do
  use Stripe.Entity

  @moduledoc "As a [card issuer](https://stripe.com/docs/issuing), you can dispute transactions that the cardholder does not recognize, suspects to be fraudulent, or has other issues with.\n\nRelated guide: [Issuing disputes](https://stripe.com/docs/issuing/purchases/disputes)"
  (
    defstruct [
      :amount,
      :balance_transactions,
      :created,
      :currency,
      :evidence,
      :id,
      :livemode,
      :metadata,
      :object,
      :status,
      :transaction,
      :treasury
    ]

    @typedoc "The `issuing.dispute` type.\n\n  * `amount` Disputed amount in the card's currency and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). Usually the amount of the `transaction`, but can differ (usually because of currency fluctuation).\n  * `balance_transactions` List of balance transactions associated with the dispute.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` The currency the `transaction` was made in.\n  * `evidence` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` Current status of the dispute.\n  * `transaction` The transaction being disputed.\n  * `treasury` [Treasury](https://stripe.com/docs/api/treasury) details related to this dispute if it was created on a [FinancialAccount](/docs/api/treasury/financial_accounts\n"
    @type t :: %__MODULE__{
            amount: integer,
            balance_transactions: term | nil,
            created: integer,
            currency: binary,
            evidence: term,
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
            status: binary,
            transaction: binary | Stripe.Issuing.Transaction.t(),
            treasury: term | nil
          }
  )

  (
    @typedoc nil
    @type canceled :: %{
            optional(:additional_documentation) => binary | binary,
            optional(:canceled_at) => integer | binary,
            optional(:cancellation_policy_provided) => boolean | binary,
            optional(:cancellation_reason) => binary | binary,
            optional(:expected_at) => integer | binary,
            optional(:explanation) => binary | binary,
            optional(:product_description) => binary | binary,
            optional(:product_type) => :merchandise | :service,
            optional(:return_status) => :merchant_rejected | :successful,
            optional(:returned_at) => integer | binary
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
    @typedoc nil
    @type duplicate :: %{
            optional(:additional_documentation) => binary | binary,
            optional(:card_statement) => binary | binary,
            optional(:cash_receipt) => binary | binary,
            optional(:check_image) => binary | binary,
            optional(:explanation) => binary | binary,
            optional(:original_transaction) => binary
          }
  )

  (
    @typedoc "Evidence provided for the dispute."
    @type evidence :: %{
            optional(:canceled) => canceled | binary,
            optional(:duplicate) => duplicate | binary,
            optional(:fraudulent) => fraudulent | binary,
            optional(:merchandise_not_as_described) => merchandise_not_as_described | binary,
            optional(:not_received) => not_received | binary,
            optional(:other) => other | binary,
            optional(:reason) =>
              :canceled
              | :duplicate
              | :fraudulent
              | :merchandise_not_as_described
              | :not_received
              | :other
              | :service_not_as_described,
            optional(:service_not_as_described) => service_not_as_described | binary
          }
  )

  (
    @typedoc nil
    @type fraudulent :: %{
            optional(:additional_documentation) => binary | binary,
            optional(:explanation) => binary | binary
          }
  )

  (
    @typedoc nil
    @type merchandise_not_as_described :: %{
            optional(:additional_documentation) => binary | binary,
            optional(:explanation) => binary | binary,
            optional(:received_at) => integer | binary,
            optional(:return_description) => binary | binary,
            optional(:return_status) => :merchant_rejected | :successful,
            optional(:returned_at) => integer | binary
          }
  )

  (
    @typedoc nil
    @type not_received :: %{
            optional(:additional_documentation) => binary | binary,
            optional(:expected_at) => integer | binary,
            optional(:explanation) => binary | binary,
            optional(:product_description) => binary | binary,
            optional(:product_type) => :merchandise | :service
          }
  )

  (
    @typedoc nil
    @type other :: %{
            optional(:additional_documentation) => binary | binary,
            optional(:explanation) => binary | binary,
            optional(:product_description) => binary | binary,
            optional(:product_type) => :merchandise | :service
          }
  )

  (
    @typedoc nil
    @type service_not_as_described :: %{
            optional(:additional_documentation) => binary | binary,
            optional(:canceled_at) => integer | binary,
            optional(:cancellation_reason) => binary | binary,
            optional(:explanation) => binary | binary,
            optional(:received_at) => integer | binary
          }
  )

  (
    @typedoc "Params for disputes related to Treasury FinancialAccounts"
    @type treasury :: %{optional(:received_debit) => binary}
  )

  (
    nil

    @doc "<p>Returns a list of Issuing <code>Dispute</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/disputes`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :expired | :lost | :submitted | :unsubmitted | :won,
                optional(:transaction) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.Dispute.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/disputes", [], [])

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

    @doc "<p>Creates an Issuing <code>Dispute</code> object. Individual pieces of evidence within the <code>evidence</code> object are optional at this point. Stripe only validates that required evidence is present during submission. Refer to <a href=\"/docs/issuing/purchases/disputes#dispute-reasons-and-evidence\">Dispute reasons and evidence</a> for more details about evidence requirements.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/disputes`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:evidence) => evidence,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:transaction) => binary,
                optional(:treasury) => treasury
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Dispute.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/disputes", [], [])

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

    @doc "<p>Updates the specified Issuing <code>Dispute</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Properties on the <code>evidence</code> object can be unset by passing in an empty string.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/disputes/{dispute}`\n"
    (
      @spec update(
              dispute :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:evidence) => evidence,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Dispute.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(dispute, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/disputes/{dispute}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "dispute",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "dispute",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [dispute]
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

    @doc "<p>Retrieves an Issuing <code>Dispute</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/disputes/{dispute}`\n"
    (
      @spec retrieve(
              dispute :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Dispute.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(dispute, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/disputes/{dispute}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "dispute",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "dispute",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [dispute]
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

    @doc "<p>Submits an Issuing <code>Dispute</code> to the card network. Stripe validates that all evidence fields required for the dispute’s reason are present. For more details, see <a href=\"/docs/issuing/purchases/disputes#dispute-reasons-and-evidence\">Dispute reasons and evidence</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/disputes/{dispute}/submit`\n"
    (
      @spec submit(
              dispute :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Dispute.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def submit(dispute, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/disputes/{dispute}/submit",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "dispute",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "dispute",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [dispute]
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
