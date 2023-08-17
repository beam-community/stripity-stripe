defmodule Stripe.Charge do
  use Stripe.Entity

  @moduledoc "The `Charge` object represents a single attempt to move money into your Stripe account.\nPaymentIntent confirmation is the most common way to create Charges, but transferring\nmoney to a different Stripe account through Connect also creates Charges.\nSome legacy payment flows create Charges directly, which is not recommended for new integrations."
  (
    defstruct [
      :shipping,
      :id,
      :transfer_data,
      :statement_descriptor_suffix,
      :application_fee_amount,
      :disputed,
      :transfer_group,
      :status,
      :source_transfer,
      :transfer,
      :created,
      :currency,
      :refunded,
      :amount_refunded,
      :captured,
      :source,
      :authorization_code,
      :level3,
      :billing_details,
      :amount_captured,
      :object,
      :failure_code,
      :receipt_number,
      :failure_balance_transaction,
      :receipt_email,
      :application,
      :balance_transaction,
      :statement_descriptor,
      :payment_method_details,
      :invoice,
      :outcome,
      :amount,
      :fraud_details,
      :customer,
      :on_behalf_of,
      :refunds,
      :payment_intent,
      :review,
      :failure_message,
      :application_fee,
      :paid,
      :description,
      :metadata,
      :radar_options,
      :calculated_statement_descriptor,
      :livemode,
      :payment_method,
      :receipt_url
    ]

    @typedoc "The `charge` type.\n\n  * `amount` Amount intended to be collected by this payment. A positive integer representing how much to charge in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal) (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or [equivalent in charge currency](https://stripe.com/docs/currencies#minimum-and-maximum-charge-amounts). The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).\n  * `amount_captured` Amount in cents (or local equivalent) captured (can be less than the amount attribute on the charge if a partial capture was made).\n  * `amount_refunded` Amount in cents (or local equivalent) refunded (can be less than the amount attribute on the charge if a partial refund was issued).\n  * `application` ID of the Connect application that created the charge.\n  * `application_fee` The application fee (if any) for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.\n  * `application_fee_amount` The amount of the application fee (if any) requested for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.\n  * `authorization_code` Authorization code on the charge.\n  * `balance_transaction` ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds or disputes).\n  * `billing_details` \n  * `calculated_statement_descriptor` The full statement descriptor that is passed to card networks, and that is displayed on your customers' credit card and bank statements. Allows you to see what the statement descriptor looks like after the static and dynamic portions are combined.\n  * `captured` If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been captured.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` ID of the customer this charge is for if one exists.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `disputed` Whether the charge has been disputed.\n  * `failure_balance_transaction` ID of the balance transaction that describes the reversal of the balance on your account due to payment failure.\n  * `failure_code` Error code explaining reason for charge failure if available (see [the errors section](https://stripe.com/docs/error-codes) for a list of codes).\n  * `failure_message` Message to user further explaining reason for charge failure if available.\n  * `fraud_details` Information on fraud assessments for the charge.\n  * `id` Unique identifier for the object.\n  * `invoice` ID of the invoice this charge is for if one exists.\n  * `level3` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `on_behalf_of` The account (if any) the charge was made on behalf of without triggering an automatic transfer. See the [Connect documentation](https://stripe.com/docs/connect/separate-charges-and-transfers) for details.\n  * `outcome` Details about whether the payment was accepted, and why. See [understanding declines](https://stripe.com/docs/declines) for details.\n  * `paid` `true` if the charge succeeded, or was successfully authorized for later capture.\n  * `payment_intent` ID of the PaymentIntent associated with this charge, if one exists.\n  * `payment_method` ID of the payment method used in this charge.\n  * `payment_method_details` Details about the payment method at the time of the transaction.\n  * `radar_options` \n  * `receipt_email` This is the email address that the receipt for this charge was sent to.\n  * `receipt_number` This is the transaction number that appears on email receipts sent for this charge. This attribute will be `null` until a receipt has been sent.\n  * `receipt_url` This is the URL to view the receipt for this charge. The receipt is kept up-to-date to the latest state of the charge, including any refunds. If the charge is for an Invoice, the receipt will be stylized as an Invoice receipt.\n  * `refunded` Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.\n  * `refunds` A list of refunds that have been applied to the charge.\n  * `review` ID of the review associated with this charge if one exists.\n  * `shipping` Shipping information for the charge.\n  * `source` This is a legacy field that will be removed in the future. It contains the Source, Card, or BankAccount object used for the charge. For details about the payment method used for this charge, refer to `payment_method` or `payment_method_details` instead.\n  * `source_transfer` The transfer ID which created this charge. Only present if the charge came from another Stripe account. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.\n  * `statement_descriptor` For card charges, use `statement_descriptor_suffix` instead. Otherwise, you can use this value as the complete description of a charge on your customers’ statements. Must contain at least one letter, maximum 22 characters.\n  * `statement_descriptor_suffix` Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.\n  * `status` The status of the payment is either `succeeded`, `pending`, or `failed`.\n  * `transfer` ID of the transfer to the `destination` account (only applicable if the charge was created using the `destination` parameter).\n  * `transfer_data` An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.\n  * `transfer_group` A string that identifies this transaction as part of a group. See the [Connect documentation](https://stripe.com/docs/connect/separate-charges-and-transfers#transfer-options) for details.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_captured: integer,
            amount_refunded: integer,
            application: (binary | term) | nil,
            application_fee: (binary | Stripe.ApplicationFee.t()) | nil,
            application_fee_amount: integer | nil,
            authorization_code: binary,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            billing_details: term,
            calculated_statement_descriptor: binary | nil,
            captured: boolean,
            created: integer,
            currency: binary,
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            description: binary | nil,
            disputed: boolean,
            failure_balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            failure_code: binary | nil,
            failure_message: binary | nil,
            fraud_details: term | nil,
            id: binary,
            invoice: (binary | Stripe.Invoice.t()) | nil,
            level3: term,
            livemode: boolean,
            metadata: term,
            object: binary,
            on_behalf_of: (binary | Stripe.Account.t()) | nil,
            outcome: term | nil,
            paid: boolean,
            payment_intent: (binary | Stripe.PaymentIntent.t()) | nil,
            payment_method: binary | nil,
            payment_method_details: term | nil,
            radar_options: term,
            receipt_email: binary | nil,
            receipt_number: binary | nil,
            receipt_url: binary | nil,
            refunded: boolean,
            refunds: term | nil,
            review: (binary | Stripe.Review.t()) | nil,
            shipping: term | nil,
            source: Stripe.PaymentSource.t() | nil,
            source_transfer: (binary | Stripe.Transfer.t()) | nil,
            statement_descriptor: binary | nil,
            statement_descriptor_suffix: binary | nil,
            status: binary,
            transfer: binary | Stripe.Transfer.t(),
            transfer_data: term | nil,
            transfer_group: binary | nil
          }
  )

  (
    @typedoc "Shipping address."
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
    @type created :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc nil
    @type destination :: %{optional(:account) => binary, optional(:amount) => integer}
  )

  (
    @typedoc "A set of key-value pairs you can attach to a charge giving information about its riskiness. If you believe a charge is fraudulent, include a `user_report` key with a value of `fraudulent`. If you believe a charge is safe, include a `user_report` key with a value of `safe`. Stripe will use the information you send to improve our fraud detection algorithms."
    @type fraud_details :: %{optional(:user_report) => :fraudulent | :safe}
  )

  (
    @typedoc "Options to configure Radar. See [Radar Session](https://stripe.com/docs/radar/radar-session) for more information."
    @type radar_options :: %{optional(:session) => binary}
  )

  (
    @typedoc "Shipping information for the charge. Helps prevent fraud on charges for physical goods."
    @type shipping :: %{
            optional(:address) => address,
            optional(:carrier) => binary,
            optional(:name) => binary,
            optional(:phone) => binary,
            optional(:tracking_number) => binary
          }
  )

  (
    @typedoc "An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details."
    @type transfer_data :: %{optional(:amount) => integer, optional(:destination) => binary}
  )

  (
    nil

    @doc "<p>Search for charges you’ve previously created using Stripe’s <a href=\"/docs/search#search-query-language\">Search Query Language</a>.\nDon’t use search in read-after-write flows where strict consistency is necessary. Under normal operating\nconditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up\nto an hour behind during outages. Search functionality is not available to merchants in India.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/charges/search`\n"
    (
      @spec search(
              params :: %{
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:page) => binary,
                optional(:query) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SearchResult.t(Stripe.Charge.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def search(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/charges/search", [], [])

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

    @doc "<p>Returns a list of charges you’ve previously created. The charges are returned in sorted order, with the most recent charges appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/charges`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:payment_intent) => binary,
                optional(:starting_after) => binary,
                optional(:transfer_group) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Charge.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/charges", [], [])

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

    @doc "<p>Use the <a href=\"/docs/api/payment_intents\">Payment Intents API</a> to initiate a new payment instead\nof using this method. Confirmation of the PaymentIntent creates the <code>Charge</code>\nobject used to request payment, so this method is limited to legacy integrations.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/charges`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:application_fee) => integer,
                optional(:application_fee_amount) => integer,
                optional(:capture) => boolean,
                optional(:currency) => binary,
                optional(:customer) => binary,
                optional(:description) => binary,
                optional(:destination) => destination,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:on_behalf_of) => binary,
                optional(:radar_options) => radar_options,
                optional(:receipt_email) => binary,
                optional(:shipping) => shipping,
                optional(:source) => binary,
                optional(:statement_descriptor) => binary,
                optional(:statement_descriptor_suffix) => binary,
                optional(:transfer_data) => transfer_data,
                optional(:transfer_group) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Charge.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/charges", [], [])

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

    @doc "<p>Retrieves the details of a charge that has previously been created. Supply the unique charge ID that was returned from your previous request, and Stripe will return the corresponding charge information. The same information is returned when creating or refunding the charge.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/charges/{charge}`\n"
    (
      @spec retrieve(
              charge :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Charge.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(charge, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/charges/{charge}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "charge",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "charge",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [charge]
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

    @doc "<p>Updates the specified charge by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/charges/{charge}`\n"
    (
      @spec update(
              charge :: binary(),
              params :: %{
                optional(:customer) => binary,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:fraud_details) => fraud_details,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:receipt_email) => binary,
                optional(:shipping) => shipping,
                optional(:transfer_group) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Charge.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(charge, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/charges/{charge}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "charge",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "charge",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [charge]
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

    @doc "<p>Capture the payment of an existing, uncaptured charge that was created with the <code>capture</code> option set to false.</p>\n\n<p>Uncaptured payments expire a set number of days after they are created (<a href=\"/docs/charges/placing-a-hold\">7 by default</a>), after which they are marked as refunded and capture attempts will fail.</p>\n\n<p>Don’t use this method to capture a PaymentIntent-initiated charge. Use <a href=\"/docs/api/payment_intents/capture\">Capture a PaymentIntent</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/charges/{charge}/capture`\n"
    (
      @spec capture(
              charge :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:application_fee) => integer,
                optional(:application_fee_amount) => integer,
                optional(:expand) => list(binary),
                optional(:receipt_email) => binary,
                optional(:statement_descriptor) => binary,
                optional(:statement_descriptor_suffix) => binary,
                optional(:transfer_data) => transfer_data,
                optional(:transfer_group) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Charge.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def capture(charge, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/charges/{charge}/capture",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "charge",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "charge",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [charge]
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
