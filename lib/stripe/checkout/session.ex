defmodule Stripe.Session do
  @moduledoc """
  Work with Stripe Checkout Session objects.

  You can:

  - Create a new session
  - Retrieve a session

  Stripe API reference: https://stripe.com/docs/api/checkout/sessions
  """

  use Stripe.Entity
  import Stripe.Request

  @type customer_update_param :: %{
          optional(:address) => String.t(),
          optional(:name) => String.t(),
          optional(:shipping) => String.t()
        }

  @type discount_param :: %{
          optional(:coupon) => String.t(),
          optional(:promotion_code) => String.t()
        }

  @type setup_intent_data :: %{
          optional(:description) => String.t(),
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:on_behalf_of) => String.t()
        }

  @type shipping_address_collection :: %{
          allowed_countries: [String.t()]
        }

  @typedoc """
  For sessions in `payment` mode only.
  One of `"auto"`, `"pay"`, `"book"`, or `"donate"`.
  """
  @type submit_type :: String.t()

  @type breakdown_discount :: %{
          amount: integer(),
          discount: Stripe.Discount.t()
        }

  @type breakdown_tax :: %{
          amount: integer(),
          rate: Stripe.TaxID.t()
        }

  @type total_details :: %{
          :amount_discount => integer(),
          :amount_shipping => integer(),
          :amount_tax => integer(),
          optional(:breakdown) => %{
            discounts: [breakdown_discount()],
            taxes: [breakdown_tax()]
          }
        }

  @type tax_id_collection :: %{
          enabled: boolean()
        }

  @typedoc """
  One of `"personal"` or  "business"`.
  """
  @type acss_mandate_transaction_type :: String.t()

  @typedoc """
  One of `"interval"`, `"sporadic"`, or  "combined"`.
  """
  @type acss_mandate_payment_schedule :: String.t()

  @type acss_mandate_options :: %{
          url: String.t(),
          default_for: [String.t()],
          interval_description: String.t() | nil,
          payment_schedule: acss_mandate_payment_schedule() | nil,
          transaction_type: acss_mandate_transaction_type()
        }

  @typedoc """
  One of `"automatic"`, `"instant"`, or  "microdeposits"`.
  """
  @type acss_verification_method :: String.t()

  @type acss_debit :: %{
          currency: String.t() | nil,
          mandate_options: acss_mandate_options() | nil,
          verification_method: acss_verification_method()
        }

  @type boleto :: %{
          expires_after_days: non_neg_integer() | nil
        }

  @type oxxo :: %{
          expires_after_days: non_neg_integer() | nil
        }

  @type payment_method_options :: %{
          acss_debit: acss_debit() | nil,
          boleto: boleto() | nil,
          oxxo: oxxo() | nil
        }

  @type customer_details :: %{
          email: String.t() | nil,
          tax_exempt: String.t() | nil,
          tax_ids: [Stripe.TaxID.tax_id_data()]
        }

  @type consent :: %{
          promotions: String.t()
        }

  @type consent_collection :: %{
          promotions: String.t()
        }

  @typedoc """
  One of `"requires_location_inputs"`, `"complete"`, `"failed"`.
  """
  @type automatic_tax_status :: String.t()

  @type automatic_tax :: %{
          enabled: boolean(),
          status: automatic_tax_status() | nil
        }

  @type automatic_tax_param :: %{
          enabled: boolean()
        }

  @type expiration :: %{
          optional(:recovery) => %{
            optional(:allow_promotion_codes) => boolean(),
            optional(:enabled) => boolean(),
            :expires_at => Stripe.timestamp(),
            :url => String.t()
          }
        }

  @type line_item :: %{
          optional(:name) => String.t(),
          optional(:quantity) => integer(),
          optional(:adjustable_quantity) => adjustable_quantity(),
          optional(:amount) => integer(),
          optional(:currency) => String.t(),
          optional(:description) => String.t(),
          optional(:dynamic_tax_rates) => list(String.t()),
          optional(:images) => list(String.t()),
          optional(:price) => String.t(),
          optional(:price_data) => price_data,
          optional(:tax_rates) => list(String.t())
        }

  @type adjustable_quantity :: %{
          :enabled => boolean(),
          optional(:maximum) => integer(),
          optional(:minimum) => integer()
        }

  @type price_data :: %{
          :currency => String.t(),
          optional(:product) => String.t(),
          optional(:product_data) => product_data(),
          optional(:unit_amount) => integer(),
          optional(:unit_amount_decimal) => integer(),
          optional(:recurring) => recurring()
        }

  @type product_data :: %{
          :name => String.t(),
          optional(:description) => String.t(),
          optional(:images) => list(String.t()),
          optional(:metadata) => Stripe.Types.metadata()
        }

  @type recurring :: %{
          :interval => String.t(),
          :interval_count => integer()
        }

  @type capture_method :: :automatic | :manual

  @type transfer_data :: %{
          :destination => String.t()
        }

  @type payment_intent_data :: %{
          optional(:application_fee_amount) => integer(),
          optional(:capture_method) => capture_method,
          optional(:description) => String.t(),
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:on_behalf_of) => String.t(),
          optional(:receipt_email) => String.t(),
          optional(:setup_future_usage) => String.t(),
          optional(:shipping) => Stripe.Types.shipping(),
          optional(:statement_descriptor) => String.t(),
          optional(:transfer_data) => transfer_data
        }

  @type item :: %{
          :plan => String.t(),
          optional(:quantity) => integer()
        }

  @type subscription_data :: %{
          :items => list(item),
          optional(:application_fee_percent) => float(),
          optional(:coupon) => String.t(),
          optional(:default_tax_rates) => list(String.t()),
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:trial_end) => integer(),
          optional(:trial_from_plan) => boolean(),
          optional(:trial_period_days) => integer()
        }

  @type create_params :: %{
          :cancel_url => String.t(),
          :payment_method_types => list(String.t()),
          :success_url => String.t(),
          optional(:mode) => String.t(),
          optional(:client_reference_id) => String.t(),
          optional(:customer) => String.t(),
          optional(:customer_email) => String.t(),
          optional(:line_items) => list(line_item),
          optional(:locale) => String.t(),
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:after_expiration) => expiration(),
          optional(:allow_promotion_codes) => boolean(),
          optional(:automatic_tax) => automatic_tax_param(),
          optional(:consent_collection) => consent_collection(),
          optional(:customer_update) => customer_update_param(),
          optional(:discounts) => [discount_param()],
          optional(:expires_at) => Stripe.timestamp(),
          optional(:payment_intent_data) => payment_intent_data,
          optional(:payment_method_options) => payment_method_options(),
          optional(:setup_intent_data) => setup_intent_data(),
          optional(:shipping_address_collection) => shipping_address_collection(),
          optional(:submit_type) => submit_type(),
          optional(:subscription_data) => subscription_data,
          optional(:tax_id_collection) => tax_id_collection()
        }

  @typedoc """
  One of `"payment"`, `"setup"`, or `"subscription"`.
  """
  @type mode :: String.t()

  @typedoc """
  One of `"paid"`, `"unpaid"`, or `"no_payment_required"`.
  """
  @type payment_status :: String.t()

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          after_expiration: expiration() | nil,
          allow_promotion_codes: boolean() | nil,
          amount_subtotal: integer() | nil,
          amount_total: integer() | nil,
          automatic_tax: automatic_tax(),
          billing_address_collection: String.t(),
          cancel_url: boolean(),
          client_reference_id: String.t(),
          consent: consent() | nil,
          consent_collection: consent_collection() | nil,
          currency: String.t(),
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          customer_details: customer_details() | nil,
          customer_email: String.t(),
          display_items: list(line_item),
          expires_at: Stripe.timestamp() | nil,
          livemode: boolean(),
          locale: boolean(),
          metadata: Stripe.Types.metadata(),
          mode: mode(),
          payment_intent: Stripe.id() | Stripe.PaymentIntent.t() | nil,
          payment_method_options: payment_method_options() | nil,
          payment_method_types: list(String.t()),
          payment_status: payment_status(),
          recovered_from: Stripe.id() | nil,
          setup_intent: Stripe.id() | Stripe.SetupIntent.t() | nil,
          shipping: %{
            address: Stripe.Types.shipping(),
            name: String.t()
          },
          shipping_address_collection: shipping_address_collection(),
          submit_type: submit_type() | nil,
          subscription: Stripe.id() | Stripe.Subscription.t() | nil,
          success_url: String.t(),
          tax_id_collection: tax_id_collection() | nil,
          total_details: total_details() | nil,
          url: String.t()
        }

  defstruct [
    :id,
    :object,
    :after_expiration,
    :allow_promotion_codes,
    :amount_subtotal,
    :amount_total,
    :automatic_tax,
    :billing_address_collection,
    :cancel_url,
    :client_reference_id,
    :consent,
    :consent_collection,
    :currency,
    :customer,
    :customer_details,
    :customer_email,
    :display_items,
    :expires_at,
    :livemode,
    :locale,
    :metadata,
    :mode,
    :payment_intent,
    :payment_method_options,
    :payment_method_types,
    :recovered_from,
    :setup_intent,
    :shipping,
    :shipping_address_collection,
    :submit_type,
    :subscription,
    :success_url,
    :tax_id_collection,
    :total_details,
    :url,
    :payment_status
  ]

  @plural_endpoint "checkout/sessions"

  @spec create(create_params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a session.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  defdelegate list_line_items(id, opts \\ []), to: Stripe.Checkout.Session.LineItems, as: :list
end
