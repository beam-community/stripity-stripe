defmodule Stripe.Source do
  use Stripe.Entity

  @moduledoc "`Source` objects allow you to accept a variety of payment methods. They\nrepresent a customer's payment instrument, and can be used with the Stripe API\njust like a `Card` object: once chargeable, they can be charged, or can be\nattached to customers.\n\nStripe doesn't recommend using the deprecated [Sources API](https://stripe.com/docs/api/sources).\nWe recommend that you adopt the [PaymentMethods API](https://stripe.com/docs/api/payment_methods).\nThis newer API provides access to our latest features and payment method types.\n\nRelated guides: [Sources API](https://stripe.com/docs/sources) and [Sources & Customers](https://stripe.com/docs/sources/customers)."
  (
    defstruct [
      :sepa_debit,
      :flow,
      :three_d_secure,
      :livemode,
      :customer,
      :statement_descriptor,
      :type,
      :redirect,
      :source_order,
      :wechat,
      :created,
      :p24,
      :acss_debit,
      :status,
      :code_verification,
      :id,
      :card,
      :currency,
      :klarna,
      :usage,
      :multibanco,
      :giropay,
      :object,
      :owner,
      :receiver,
      :ideal,
      :client_secret,
      :eps,
      :bancontact,
      :ach_debit,
      :sepa_credit_transfer,
      :ach_credit_transfer,
      :card_present,
      :amount,
      :metadata,
      :au_becs_debit,
      :alipay,
      :sofort
    ]

    @typedoc "The `source` type.\n\n  * `ach_credit_transfer` \n  * `ach_debit` \n  * `acss_debit` \n  * `alipay` \n  * `amount` A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount associated with the source. This is the amount for which the source will be chargeable once ready. Required for `single_use` sources.\n  * `au_becs_debit` \n  * `bancontact` \n  * `card` \n  * `card_present` \n  * `client_secret` The client secret of the source. Used for client-side retrieval using a publishable key.\n  * `code_verification` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) associated with the source. This is the currency for which the source will be chargeable once ready. Required for `single_use` sources.\n  * `customer` The ID of the customer to which this source is attached. This will not be present when the source has not been attached to a customer.\n  * `eps` \n  * `flow` The authentication `flow` of the source. `flow` is one of `redirect`, `receiver`, `code_verification`, `none`.\n  * `giropay` \n  * `id` Unique identifier for the object.\n  * `ideal` \n  * `klarna` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `multibanco` \n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `owner` Information about the owner of the payment instrument that may be used or required by particular source types.\n  * `p24` \n  * `receiver` \n  * `redirect` \n  * `sepa_credit_transfer` \n  * `sepa_debit` \n  * `sofort` \n  * `source_order` \n  * `statement_descriptor` Extra information about a source. This will appear on your customer's statement every time you charge the source.\n  * `status` The status of the source, one of `canceled`, `chargeable`, `consumed`, `failed`, or `pending`. Only `chargeable` sources can be used to create a charge.\n  * `three_d_secure` \n  * `type` The `type` of the source. The `type` is a payment method, one of `ach_credit_transfer`, `ach_debit`, `alipay`, `bancontact`, `card`, `card_present`, `eps`, `giropay`, `ideal`, `multibanco`, `klarna`, `p24`, `sepa_debit`, `sofort`, `three_d_secure`, or `wechat`. An additional hash is included on the source with a name matching this value. It contains additional information specific to the [payment method](https://stripe.com/docs/sources) used.\n  * `usage` Either `reusable` or `single_use`. Whether this source should be reusable or not. Some source types may or may not be reusable by construction, while others may leave the option at creation. If an incompatible value is passed, an error will be returned.\n  * `wechat` \n"
    @type t :: %__MODULE__{
            ach_credit_transfer: term,
            ach_debit: term,
            acss_debit: term,
            alipay: term,
            amount: integer | nil,
            au_becs_debit: term,
            bancontact: term,
            card: term,
            card_present: term,
            client_secret: binary,
            code_verification: term,
            created: integer,
            currency: binary | nil,
            customer: binary,
            eps: term,
            flow: binary,
            giropay: term,
            id: binary,
            ideal: term,
            klarna: term,
            livemode: boolean,
            metadata: term | nil,
            multibanco: term,
            object: binary,
            owner: term | nil,
            p24: term,
            receiver: term,
            redirect: term,
            sepa_credit_transfer: term,
            sepa_debit: term,
            sofort: term,
            source_order: term,
            statement_descriptor: binary | nil,
            status: binary,
            three_d_secure: term,
            type: binary,
            usage: binary | nil,
            wechat: term
          }
  )

  (
    @typedoc "The parameters required to notify Stripe of a mandate acceptance or refusal by the customer."
    @type acceptance :: %{
            optional(:date) => integer,
            optional(:ip) => binary,
            optional(:offline) => offline,
            optional(:online) => online,
            optional(:status) => :accepted | :pending | :refused | :revoked,
            optional(:type) => :offline | :online,
            optional(:user_agent) => binary
          }
  )

  (
    @typedoc "Owner's address."
    @type address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    @typedoc nil
    @type items :: %{
            optional(:amount) => integer,
            optional(:currency) => binary,
            optional(:description) => binary,
            optional(:parent) => binary,
            optional(:quantity) => integer,
            optional(:type) => :discount | :shipping | :sku | :tax
          }
  )

  (
    @typedoc "Information about a mandate possibility attached to a source object (generally for bank debits) as well as its acceptance status."
    @type mandate :: %{
            optional(:acceptance) => acceptance,
            optional(:amount) => integer | binary,
            optional(:currency) => binary,
            optional(:interval) => :one_time | :scheduled | :variable,
            optional(:notification_method) =>
              :deprecated_none | :email | :manual | :none | :stripe_email
          }
  )

  (
    @typedoc "The parameters required to store a mandate accepted offline. Should only be set if `mandate[type]` is `offline`"
    @type offline :: %{optional(:contact_email) => binary}
  )

  (
    @typedoc "The parameters required to store a mandate accepted online. Should only be set if `mandate[type]` is `online`"
    @type online :: %{
            optional(:date) => integer,
            optional(:ip) => binary,
            optional(:user_agent) => binary
          }
  )

  (
    @typedoc "Information about the owner of the payment instrument that may be used or required by particular source types."
    @type owner :: %{
            optional(:address) => address,
            optional(:email) => binary,
            optional(:name) => binary,
            optional(:phone) => binary
          }
  )

  (
    @typedoc "Optional parameters for the receiver flow. Can be set only if the source is a receiver (`flow` is `receiver`)."
    @type receiver :: %{optional(:refund_attributes_method) => :email | :manual | :none}
  )

  (
    @typedoc "Parameters required for the redirect flow. Required if the source is authenticated by a redirect (`flow` is `redirect`)."
    @type redirect :: %{optional(:return_url) => binary}
  )

  (
    @typedoc "Shipping address for the order. Required if any of the SKUs are for products that have `shippable` set to true."
    @type shipping :: %{
            optional(:address) => address,
            optional(:carrier) => binary,
            optional(:name) => binary,
            optional(:phone) => binary,
            optional(:tracking_number) => binary
          }
  )

  (
    @typedoc "Information about the items and shipping associated with the source. Required for transactional credit (for example Klarna) sources before you can charge it."
    @type source_order :: %{optional(:items) => list(items), optional(:shipping) => shipping}
  )

  (
    nil

    @doc "<p>Delete a specified source for a given customer.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/customers/{customer}/sources/{id}`\n"
    (
      @spec detach(
              customer :: binary(),
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentSource.t() | Stripe.DeletedPaymentSource.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def detach(customer, id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/sources/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
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
            [customer, id]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Retrieves an existing source object. Supply the unique source ID from a source creation request and Stripe will return the corresponding up-to-date source object information.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/sources/{source}`\n"
    (
      @spec retrieve(
              source :: binary(),
              params :: %{optional(:client_secret) => binary, optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Source.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(source, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/sources/{source}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "source",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "source",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [source]
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

    @doc "<p>List source transactions for a given source.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/sources/{source}/source_transactions`\n"
    (
      @spec source_transactions(
              source :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.SourceTransaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def source_transactions(source, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/sources/{source}/source_transactions",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "source",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "source",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [source]
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

    @doc "<p>Creates a new source object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/sources`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:customer) => binary,
                optional(:expand) => list(binary),
                optional(:flow) => :code_verification | :none | :receiver | :redirect,
                optional(:mandate) => mandate,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:original_source) => binary,
                optional(:owner) => owner,
                optional(:receiver) => receiver,
                optional(:redirect) => redirect,
                optional(:source_order) => source_order,
                optional(:statement_descriptor) => binary,
                optional(:token) => binary,
                optional(:type) => binary,
                optional(:usage) => :reusable | :single_use
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Source.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/sources", [], [])

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

    @doc "<p>Updates the specified source by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n<p>This request accepts the <code>metadata</code> and <code>owner</code> as arguments. It is also possible to update type specific information for selected payment methods. Please refer to our <a href=\"/docs/sources\">payment method guides</a> for more detail.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/sources/{source}`\n"
    (
      @spec update(
              source :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:expand) => list(binary),
                optional(:mandate) => mandate,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:owner) => owner,
                optional(:source_order) => source_order
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Source.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(source, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/sources/{source}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "source",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "source",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [source]
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

    @doc "<p>Verify a given source.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/sources/{source}/verify`\n"
    (
      @spec verify(
              source :: binary(),
              params :: %{optional(:expand) => list(binary), optional(:values) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Source.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def verify(source, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/sources/{source}/verify",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "source",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "source",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [source]
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
