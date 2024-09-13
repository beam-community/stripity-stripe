defmodule Stripe.Forwarding.Request do
  use Stripe.Entity

  @moduledoc "Instructs Stripe to make a request on your behalf using the destination URL. The destination URL\nis activated by Stripe at the time of onboarding. Stripe verifies requests with your credentials\nprovided during onboarding, and injects card details from the payment_method into the request.\n\nStripe redacts all sensitive fields and headers, including authentication credentials and card numbers,\nbefore storing the request and response data in the forwarding Request object, which are subject to a\n30-day retention period.\n\nYou can provide a Stripe idempotency key to make sure that requests with the same key result in only one\noutbound request. The Stripe idempotency key provided should be unique and different from any idempotency\nkeys provided on the underlying third-party request.\n\nForwarding Requests are synchronous requests that return a response or time out according to\nStripe’s limits.\n\nRelated guide: [Forward card details to third-party API endpoints](https://docs.stripe.com/payments/forwarding)."
  (
    defstruct [
      :created,
      :id,
      :livemode,
      :object,
      :payment_method,
      :replacements,
      :request_context,
      :request_details,
      :response_details,
      :url
    ]

    @typedoc "The `forwarding.request` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_method` The PaymentMethod to insert into the forwarded request. Forwarding previously consumed PaymentMethods is allowed.\n  * `replacements` The field kinds to be replaced in the forwarded request.\n  * `request_context` Context about the request from Stripe's servers to the destination endpoint.\n  * `request_details` The request that was sent to the destination endpoint. We redact any sensitive fields.\n  * `response_details` The response that the destination endpoint returned to us. We redact any sensitive fields.\n  * `url` The destination URL for the forwarded request. Must be supported by the config.\n"
    @type t :: %__MODULE__{
            created: integer,
            id: binary,
            livemode: boolean,
            object: binary,
            payment_method: binary,
            replacements: term,
            request_context: term | nil,
            request_details: term | nil,
            response_details: term | nil,
            url: binary | nil
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
    @type headers :: %{optional(:name) => binary, optional(:value) => binary}
  )

  (
    @typedoc "The request body and headers to be sent to the destination endpoint."
    @type request :: %{optional(:body) => binary, optional(:headers) => list(headers)}
  )

  (
    nil

    @doc "<p>Lists all ForwardingRequest objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/forwarding/requests`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Forwarding.Request.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/forwarding/requests", [], [])

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

    @doc "<p>Retrieves a ForwardingRequest object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/forwarding/requests/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Forwarding.Request.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/forwarding/requests/{id}",
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

    @doc "<p>Creates a ForwardingRequest object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/forwarding/requests`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:payment_method) => binary,
                optional(:replacements) =>
                  list(:card_cvc | :card_expiry | :card_number | :cardholder_name),
                optional(:request) => request,
                optional(:url) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Forwarding.Request.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/forwarding/requests", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end