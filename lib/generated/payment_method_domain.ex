defmodule Stripe.PaymentMethodDomain do
  use Stripe.Entity

  @moduledoc "A payment method domain represents a web domain that you have registered with Stripe.\nStripe Elements use registered payment method domains to control where certain payment methods are shown.\n\nRelated guide: [Payment method domains](https://stripe.com/docs/payments/payment-methods/pmd-registration)."
  (
    defstruct [
      :apple_pay,
      :created,
      :domain_name,
      :enabled,
      :google_pay,
      :id,
      :link,
      :livemode,
      :object,
      :paypal
    ]

    @typedoc "The `payment_method_domain` type.\n\n  * `apple_pay` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `domain_name` The domain name that this payment method domain object represents.\n  * `enabled` Whether this payment method domain is enabled. If the domain is not enabled, payment methods that require a payment method domain will not appear in Elements.\n  * `google_pay` \n  * `id` Unique identifier for the object.\n  * `link` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `paypal` \n"
    @type t :: %__MODULE__{
            apple_pay: term,
            created: integer,
            domain_name: binary,
            enabled: boolean,
            google_pay: term,
            id: binary,
            link: term,
            livemode: boolean,
            object: binary,
            paypal: term
          }
  )

  (
    nil

    @doc "<p>Lists the details of existing payment method domains.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_method_domains`\n"
    (
      @spec list(
              params :: %{
                optional(:domain_name) => binary,
                optional(:enabled) => boolean,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PaymentMethodDomain.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payment_method_domains", [], [])

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

    @doc "<p>Retrieves the details of an existing payment method domain.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_method_domains/{payment_method_domain}`\n"
    (
      @spec retrieve(
              payment_method_domain :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethodDomain.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(payment_method_domain, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_method_domains/{payment_method_domain}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_method_domain",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_method_domain",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_method_domain]
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

    @doc "<p>Creates a payment method domain.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_method_domains`\n"
    (
      @spec create(
              params :: %{
                optional(:domain_name) => binary,
                optional(:enabled) => boolean,
                optional(:expand) => list(binary)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethodDomain.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payment_method_domains", [], [])

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

    @doc "<p>Updates an existing payment method domain.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_method_domains/{payment_method_domain}`\n"
    (
      @spec update(
              payment_method_domain :: binary(),
              params :: %{optional(:enabled) => boolean, optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethodDomain.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(payment_method_domain, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_method_domains/{payment_method_domain}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_method_domain",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_method_domain",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_method_domain]
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

    @doc "<p>Some payment methods such as Apple Pay require additional steps to verify a domain. If the requirements weren’t satisfied when the domain was created, the payment method will be inactive on the domain.\nThe payment method doesn’t appear in Elements for this domain until it is active.</p>\n\n<p>To activate a payment method on an existing payment method domain, complete the required validation steps specific to the payment method, and then validate the payment method domain with this endpoint.</p>\n\n<p>Related guides: <a href=\"/docs/payments/payment-methods/pmd-registration\">Payment method domains</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_method_domains/{payment_method_domain}/validate`\n"
    (
      @spec validate(
              payment_method_domain :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethodDomain.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def validate(payment_method_domain, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_method_domains/{payment_method_domain}/validate",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_method_domain",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_method_domain",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_method_domain]
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