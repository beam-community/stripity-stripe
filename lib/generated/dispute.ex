defmodule Stripe.Dispute do
  use Stripe.Entity

  @moduledoc "A dispute occurs when a customer questions your charge with their card issuer.\nWhen this happens, you have the opportunity to respond to the dispute with\nevidence that shows that the charge is legitimate.\n\nRelated guide: [Disputes and fraud](https://stripe.com/docs/disputes)"
  (
    defstruct [
      :amount,
      :balance_transactions,
      :charge,
      :created,
      :currency,
      :evidence,
      :evidence_details,
      :id,
      :is_charge_refundable,
      :livemode,
      :metadata,
      :network_reason_code,
      :object,
      :payment_intent,
      :payment_method_details,
      :reason,
      :status
    ]

    @typedoc "The `dispute` type.\n\n  * `amount` Disputed amount. Usually the amount of the charge, but it can differ (usually because of currency fluctuation or because only part of the order is disputed).\n  * `balance_transactions` List of zero, one, or two balance transactions that show funds withdrawn and reinstated to your Stripe account as a result of this dispute.\n  * `charge` ID of the charge that's disputed.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `evidence` \n  * `evidence_details` \n  * `id` Unique identifier for the object.\n  * `is_charge_refundable` If true, it's still possible to refund the disputed payment. After the payment has been fully refunded, no further funds are withdrawn from your Stripe account as a result of this dispute.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `network_reason_code` Network-dependent reason code for the dispute.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_intent` ID of the PaymentIntent that's disputed.\n  * `payment_method_details` \n  * `reason` Reason given by cardholder for dispute. Possible values are `bank_cannot_process`, `check_returned`, `credit_not_processed`, `customer_initiated`, `debit_not_authorized`, `duplicate`, `fraudulent`, `general`, `incorrect_account_details`, `insufficient_funds`, `product_not_received`, `product_unacceptable`, `subscription_canceled`, or `unrecognized`. Learn more about [dispute reasons](https://stripe.com/docs/disputes/categories).\n  * `status` Current status of dispute. Possible values are `warning_needs_response`, `warning_under_review`, `warning_closed`, `needs_response`, `under_review`, `won`, or `lost`.\n"
    @type t :: %__MODULE__{
            amount: integer,
            balance_transactions: term,
            charge: binary | Stripe.Charge.t(),
            created: integer,
            currency: binary,
            evidence: term,
            evidence_details: term,
            id: binary,
            is_charge_refundable: boolean,
            livemode: boolean,
            metadata: term,
            network_reason_code: binary | nil,
            object: binary,
            payment_intent: (binary | Stripe.PaymentIntent.t()) | nil,
            payment_method_details: term,
            reason: binary,
            status: binary
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
    @typedoc "Evidence to upload, to respond to a dispute. Updating any field in the hash will submit all fields in the hash for review. The combined character count of all fields is limited to 150,000."
    @type evidence :: %{
            optional(:access_activity_log) => binary,
            optional(:billing_address) => binary,
            optional(:cancellation_policy) => binary,
            optional(:cancellation_policy_disclosure) => binary,
            optional(:cancellation_rebuttal) => binary,
            optional(:customer_communication) => binary,
            optional(:customer_email_address) => binary,
            optional(:customer_name) => binary,
            optional(:customer_purchase_ip) => binary,
            optional(:customer_signature) => binary,
            optional(:duplicate_charge_documentation) => binary,
            optional(:duplicate_charge_explanation) => binary,
            optional(:duplicate_charge_id) => binary,
            optional(:product_description) => binary,
            optional(:receipt) => binary,
            optional(:refund_policy) => binary,
            optional(:refund_policy_disclosure) => binary,
            optional(:refund_refusal_explanation) => binary,
            optional(:service_date) => binary,
            optional(:service_documentation) => binary,
            optional(:shipping_address) => binary,
            optional(:shipping_carrier) => binary,
            optional(:shipping_date) => binary,
            optional(:shipping_documentation) => binary,
            optional(:shipping_tracking_number) => binary,
            optional(:uncategorized_file) => binary,
            optional(:uncategorized_text) => binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of your disputes.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/disputes`\n"
    (
      @spec list(
              params :: %{
                optional(:charge) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:payment_intent) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Dispute.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/disputes", [], [])

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

    @doc "<p>Retrieves the dispute with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/disputes/{dispute}`\n"
    (
      @spec retrieve(
              dispute :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Dispute.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(dispute, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/disputes/{dispute}",
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

    @doc "<p>When you get a dispute, contacting your customer is always the best first step. If that doesn’t work, you can submit evidence to help us resolve the dispute in your favor. You can do this in your <a href=\"https://dashboard.stripe.com/disputes\">dashboard</a>, but if you prefer, you can use the API to submit evidence programmatically.</p>\n\n<p>Depending on your dispute type, different evidence fields will give you a better chance of winning your dispute. To figure out which evidence fields to provide, see our <a href=\"/docs/disputes/categories\">guide to dispute types</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/disputes/{dispute}`\n"
    (
      @spec update(
              dispute :: binary(),
              params :: %{
                optional(:evidence) => evidence,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:submit) => boolean
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Dispute.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(dispute, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/disputes/{dispute}",
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

    @doc "<p>Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially dismissing the dispute, acknowledging it as lost.</p>\n\n<p>The status of the dispute will change from <code>needs_response</code> to <code>lost</code>. <em>Closing a dispute is irreversible</em>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/disputes/{dispute}/close`\n"
    (
      @spec close(
              dispute :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Dispute.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def close(dispute, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/disputes/{dispute}/close",
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
