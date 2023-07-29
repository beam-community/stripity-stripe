defmodule Stripe.Issuing.Authorization do
  use Stripe.Entity

  @moduledoc "When an [issued card](https://stripe.com/docs/issuing) is used to make a purchase, an Issuing `Authorization`\nobject is created. [Authorizations](https://stripe.com/docs/issuing/purchases/authorizations) must be approved for the\npurchase to be completed successfully.\n\nRelated guide: [Issued card authorizations](https://stripe.com/docs/issuing/purchases/authorizations)"
  (
    defstruct [
      :amount,
      :amount_details,
      :approved,
      :authorization_method,
      :balance_transactions,
      :card,
      :cardholder,
      :created,
      :currency,
      :id,
      :livemode,
      :merchant_amount,
      :merchant_currency,
      :merchant_data,
      :metadata,
      :network_data,
      :object,
      :pending_request,
      :request_history,
      :status,
      :transactions,
      :treasury,
      :verification_data,
      :wallet
    ]

    @typedoc "The `issuing.authorization` type.\n\n  * `amount` The total amount that was authorized or rejected. This amount is in the card's currency and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `amount_details` Detailed breakdown of amount components. These amounts are denominated in `currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `approved` Whether the authorization has been approved.\n  * `authorization_method` How the card details were provided.\n  * `balance_transactions` List of balance transactions associated with this authorization.\n  * `card` \n  * `cardholder` The cardholder to whom this authorization belongs.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `merchant_amount` The total amount that was authorized or rejected. This amount is in the `merchant_currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `merchant_currency` The currency that was presented to the cardholder for the authorization. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `merchant_data` \n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `network_data` Details about the authorization, such as identifiers, set by the card network.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `pending_request` The pending authorization request. This field will only be non-null during an `issuing_authorization.request` webhook.\n  * `request_history` History of every time a `pending_request` authorization was approved/declined, either by you directly or by Stripe (e.g. based on your spending_controls). If the merchant changes the authorization by performing an incremental authorization, you can look at this field to see the previous requests for the authorization. This field can be helpful in determining why a given authorization was approved/declined.\n  * `status` The current status of the authorization in its lifecycle.\n  * `transactions` List of [transactions](https://stripe.com/docs/api/issuing/transactions) associated with this authorization.\n  * `treasury` [Treasury](https://stripe.com/docs/api/treasury) details related to this authorization if it was created on a [FinancialAccount](https://stripe.com/docs/api/treasury/financial_accounts).\n  * `verification_data` \n  * `wallet` The digital wallet used for this transaction. One of `apple_pay`, `google_pay`, or `samsung_pay`. Will populate as `null` when no digital wallet was utilized.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_details: term | nil,
            approved: boolean,
            authorization_method: binary,
            balance_transactions: term,
            card: Stripe.Issuing.Card.t(),
            cardholder: (binary | Stripe.Issuing.Cardholder.t()) | nil,
            created: integer,
            currency: binary,
            id: binary,
            livemode: boolean,
            merchant_amount: integer,
            merchant_currency: binary,
            merchant_data: term,
            metadata: term,
            network_data: term | nil,
            object: binary,
            pending_request: term | nil,
            request_history: term,
            status: binary,
            transactions: term,
            treasury: term | nil,
            verification_data: term,
            wallet: binary | nil
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

    @doc "<p>Returns a list of Issuing <code>Authorization</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/authorizations`\n"
    (
      @spec list(
              params :: %{
                optional(:card) => binary,
                optional(:cardholder) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :closed | :pending | :reversed
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.Authorization.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/authorizations", [], [])

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

    @doc "<p>Retrieves an Issuing <code>Authorization</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/authorizations/{authorization}`\n"
    (
      @spec retrieve(
              authorization :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Updates the specified Issuing <code>Authorization</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/authorizations/{authorization}`\n"
    (
      @spec update(
              authorization :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Approves a pending Issuing <code>Authorization</code> object. This request should be made within the timeout window of the <a href=\"/docs/issuing/controls/real-time-authorizations\">real-time authorization</a> flow. \nYou can also respond directly to the webhook request to approve an authorization (preferred). More details can be found <a href=\"/docs/issuing/controls/real-time-authorizations#authorization-handling\">here</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/authorizations/{authorization}/approve`\n"
    (
      @spec approve(
              authorization :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def approve(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}/approve",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Declines a pending Issuing <code>Authorization</code> object. This request should be made within the timeout window of the <a href=\"/docs/issuing/controls/real-time-authorizations\">real time authorization</a> flow.\nYou can also respond directly to the webhook request to decline an authorization (preferred). More details can be found <a href=\"/docs/issuing/controls/real-time-authorizations#authorization-handling\">here</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/authorizations/{authorization}/decline`\n"
    (
      @spec decline(
              authorization :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def decline(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}/decline",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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
