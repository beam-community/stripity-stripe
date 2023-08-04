defmodule Stripe.Coupon do
  use Stripe.Entity

  @moduledoc "A coupon contains information about a percent-off or amount-off discount you\nmight want to apply to a customer. Coupons may be applied to [subscriptions](https://stripe.com/docs/api#subscriptions), [invoices](https://stripe.com/docs/api#invoices),\n[checkout sessions](https://stripe.com/docs/api/checkout/sessions), [quotes](https://stripe.com/docs/api#quotes), and more. Coupons do not work with conventional one-off [charges](https://stripe.com/docs/api#create_charge) or [payment intents](https://stripe.com/docs/api/payment_intents)."
  (
    defstruct [
      :amount_off,
      :applies_to,
      :created,
      :currency,
      :currency_options,
      :duration,
      :duration_in_months,
      :id,
      :livemode,
      :max_redemptions,
      :metadata,
      :name,
      :object,
      :percent_off,
      :redeem_by,
      :times_redeemed,
      :valid
    ]

    @typedoc "The `coupon` type.\n\n  * `amount_off` Amount (in the `currency` specified) that will be taken off the subtotal of any invoices for this customer.\n  * `applies_to` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` If `amount_off` has been set, the three-letter [ISO code for the currency](https://stripe.com/docs/currencies) of the amount to take off.\n  * `currency_options` Coupons defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).\n  * `duration` One of `forever`, `once`, and `repeating`. Describes how long a customer who applies this coupon will get the discount.\n  * `duration_in_months` If `duration` is `repeating`, the number of months the coupon applies. Null if coupon `duration` is `forever` or `once`.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `max_redemptions` Maximum number of times this coupon can be redeemed, in total, across all customers, before it is no longer valid.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` Name of the coupon displayed to customers on for instance invoices or receipts.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `percent_off` Percent that will be taken off the subtotal of any invoices for this customer for the duration of the coupon. For example, a coupon with percent_off of 50 will make a $ (or local equivalent)100 invoice $ (or local equivalent)50 instead.\n  * `redeem_by` Date after which the coupon can no longer be redeemed.\n  * `times_redeemed` Number of times this coupon has been applied to a customer.\n  * `valid` Taking account of the above properties, whether this coupon can still be applied to a customer.\n"
    @type t :: %__MODULE__{
            amount_off: integer | nil,
            applies_to: term,
            created: integer,
            currency: binary | nil,
            currency_options: term,
            duration: binary,
            duration_in_months: integer | nil,
            id: binary,
            livemode: boolean,
            max_redemptions: integer | nil,
            metadata: term | nil,
            name: binary | nil,
            object: binary,
            percent_off: term | nil,
            redeem_by: integer | nil,
            times_redeemed: integer,
            valid: boolean
          }
  )

  (
    @typedoc "A hash containing directions for what this Coupon will apply discounts to."
    @type applies_to :: %{optional(:products) => list(binary)}
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

    @doc "<p>Returns a list of your coupons.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/coupons`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Coupon.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/coupons", [], [])

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

    @doc "<p>You can create coupons easily via the <a href=\"https://dashboard.stripe.com/coupons\">coupon management</a> page of the Stripe dashboard. Coupon creation is also accessible via the API if you need to create coupons on the fly.</p>\n\n<p>A coupon has either a <code>percent_off</code> or an <code>amount_off</code> and <code>currency</code>. If you set an <code>amount_off</code>, that amount will be subtracted from any invoice’s subtotal. For example, an invoice with a subtotal of <currency>100</currency> will have a final total of <currency>0</currency> if a coupon with an <code>amount_off</code> of <amount>200</amount> is applied to it and an invoice with a subtotal of <currency>300</currency> will have a final total of <currency>100</currency> if a coupon with an <code>amount_off</code> of <amount>200</amount> is applied to it.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/coupons`\n"
    (
      @spec create(
              params :: %{
                optional(:amount_off) => integer,
                optional(:applies_to) => applies_to,
                optional(:currency) => binary,
                optional(:currency_options) => map(),
                optional(:duration) => :forever | :once | :repeating,
                optional(:duration_in_months) => integer,
                optional(:expand) => list(binary),
                optional(:id) => binary,
                optional(:max_redemptions) => integer,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:name) => binary,
                optional(:percent_off) => number,
                optional(:redeem_by) => integer
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Coupon.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/coupons", [], [])

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

    @doc "<p>Retrieves the coupon with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/coupons/{coupon}`\n"
    (
      @spec retrieve(
              coupon :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Coupon.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(coupon, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/coupons/{coupon}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "coupon",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "coupon",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [coupon]
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

    @doc "<p>Updates the metadata of a coupon. Other coupon details (currency, duration, amount_off) are, by design, not editable.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/coupons/{coupon}`\n"
    (
      @spec update(
              coupon :: binary(),
              params :: %{
                optional(:currency_options) => map(),
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:name) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Coupon.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(coupon, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/coupons/{coupon}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "coupon",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "coupon",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [coupon]
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

    @doc "<p>You can delete coupons via the <a href=\"https://dashboard.stripe.com/coupons\">coupon management</a> page of the Stripe dashboard. However, deleting a coupon does not affect any customers who have already applied the coupon; it means that new customers can’t redeem the coupon. You can also delete coupons via the API.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/coupons/{coupon}`\n"
    (
      @spec delete(coupon :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedCoupon.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete(coupon, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/coupons/{coupon}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "coupon",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "coupon",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [coupon]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end
