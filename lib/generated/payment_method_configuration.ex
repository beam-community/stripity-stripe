defmodule Stripe.PaymentMethodConfiguration do
  use Stripe.Entity

  @moduledoc "PaymentMethodConfigurations control which payment methods are displayed to your customers when you don't explicitly specify payment method types. You can have multiple configurations with different sets of payment methods for different scenarios.\n\nThere are two types of PaymentMethodConfigurations. Which is used depends on the [charge type](https://stripe.com/docs/connect/charges):\n\n**Direct** configurations apply to payments created on your account, including Connect destination charges, Connect separate charges and transfers, and payments not involving Connect.\n\n**Child** configurations apply to payments created on your connected accounts using direct charges, and charges with the on_behalf_of parameter.\n\nChild configurations have a `parent` that sets default values and controls which settings connected accounts may override. You can specify a parent ID at payment time, and Stripe will automatically resolve the connected account’s associated child configuration. Parent configurations are [managed in the dashboard](https://dashboard.stripe.com/settings/payment_methods/connected_accounts) and are not available in this API.\n\nRelated guides:\n- [Payment Method Configurations API](https://stripe.com/docs/connect/payment-method-configurations)\n- [Multiple payment method configurations on dynamic payment methods](https://stripe.com/docs/payments/multiple-payment-method-configs)\n- [Multiple configurations for your Connect accounts](https://stripe.com/docs/connect/multiple-payment-method-configurations)"
  (
    defstruct [
      :eps,
      :id,
      :paynow,
      :klarna,
      :sepa_debit,
      :au_becs_debit,
      :bancontact,
      :parent,
      :grabpay,
      :cartes_bancaires,
      :afterpay_clearpay,
      :google_pay,
      :p24,
      :apple_pay,
      :sofort,
      :wechat_pay,
      :blik,
      :netbanking,
      :konbini,
      :object,
      :jcb,
      :boleto,
      :paypal,
      :application,
      :us_bank_account,
      :pay_by_bank,
      :oxxo,
      :cashapp,
      :promptpay,
      :link,
      :active,
      :multibanco,
      :card,
      :upi,
      :ideal,
      :id_bank_transfer,
      :giropay,
      :alipay,
      :is_default,
      :bacs_debit,
      :acss_debit,
      :livemode,
      :affirm,
      :name,
      :fpx
    ]

    @typedoc "The `payment_method_configuration` type.\n\n  * `acss_debit` \n  * `active` Whether the configuration can be used for new payments.\n  * `affirm` \n  * `afterpay_clearpay` \n  * `alipay` \n  * `apple_pay` \n  * `application` For child configs, the Connect application associated with the configuration.\n  * `au_becs_debit` \n  * `bacs_debit` \n  * `bancontact` \n  * `blik` \n  * `boleto` \n  * `card` \n  * `cartes_bancaires` \n  * `cashapp` \n  * `eps` \n  * `fpx` \n  * `giropay` \n  * `google_pay` \n  * `grabpay` \n  * `id` Unique identifier for the object.\n  * `id_bank_transfer` \n  * `ideal` \n  * `is_default` The default configuration is used whenever a payment method configuration is not specified.\n  * `jcb` \n  * `klarna` \n  * `konbini` \n  * `link` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `multibanco` \n  * `name` The configuration's name.\n  * `netbanking` \n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `oxxo` \n  * `p24` \n  * `parent` For child configs, the configuration's parent configuration.\n  * `pay_by_bank` \n  * `paynow` \n  * `paypal` \n  * `promptpay` \n  * `sepa_debit` \n  * `sofort` \n  * `upi` \n  * `us_bank_account` \n  * `wechat_pay` \n"
    @type t :: %__MODULE__{
            acss_debit: term,
            active: boolean,
            affirm: term,
            afterpay_clearpay: term,
            alipay: term,
            apple_pay: term,
            application: binary | nil,
            au_becs_debit: term,
            bacs_debit: term,
            bancontact: term,
            blik: term,
            boleto: term,
            card: term,
            cartes_bancaires: term,
            cashapp: term,
            eps: term,
            fpx: term,
            giropay: term,
            google_pay: term,
            grabpay: term,
            id: binary,
            id_bank_transfer: term,
            ideal: term,
            is_default: boolean,
            jcb: term,
            klarna: term,
            konbini: term,
            link: term,
            livemode: boolean,
            multibanco: term,
            name: binary,
            netbanking: term,
            object: binary,
            oxxo: term,
            p24: term,
            parent: binary | nil,
            pay_by_bank: term,
            paynow: term,
            paypal: term,
            promptpay: term,
            sepa_debit: term,
            sofort: term,
            upi: term,
            us_bank_account: term,
            wechat_pay: term
          }
  )

  (
    @typedoc "Canadian pre-authorized debit payments, check this [page](https://stripe.com/docs/payments/acss-debit) for more details like country availability."
    @type acss_debit :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "[Affirm](https://www.affirm.com/) gives your customers a way to split purchases over a series of payments. Depending on the purchase, they can pay with four interest-free payments (Split Pay) or pay over a longer term (Installments), which might include interest. Check this [page](https://stripe.com/docs/payments/affirm) for more details like country availability."
    @type affirm :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Afterpay gives your customers a way to pay for purchases in installments, check this [page](https://stripe.com/docs/payments/afterpay-clearpay) for more details like country availability. Afterpay is particularly popular among businesses selling fashion, beauty, and sports products."
    @type afterpay_clearpay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Alipay is a digital wallet in China that has more than a billion active users worldwide. Alipay users can pay on the web or on a mobile device using login credentials or their Alipay app. Alipay has a low dispute rate and reduces fraud by authenticating payments using the customer's login credentials. Check this [page](https://stripe.com/docs/payments/alipay) for more details."
    @type alipay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users can accept [Apple Pay](/payments/apple-pay) in iOS applications in iOS 9 and later, and on the web in Safari starting with iOS 10 or macOS Sierra. There are no additional fees to process Apple Pay payments, and the [pricing](/pricing) is the same as other card transactions. Check this [page](https://stripe.com/docs/apple-pay) for more details."
    @type apple_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Apple Pay Later, a payment method for customers to buy now and pay later, gives your customers a way to split purchases into four installments across six weeks."
    @type apple_pay_later :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users in Australia can accept Bulk Electronic Clearing System (BECS) direct debit payments from customers with an Australian bank account. Check this [page](https://stripe.com/docs/payments/au-becs-debit) for more details."
    @type au_becs_debit :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users in the UK can accept Bacs Direct Debit payments from customers with a UK bank account, check this [page](https://stripe.com/docs/payments/payment-methods/bacs-debit) for more details."
    @type bacs_debit :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Bancontact is the most popular online payment method in Belgium, with over 15 million cards in circulation. [Customers](https://stripe.com/docs/api/customers) use a Bancontact card or mobile app linked to a Belgian bank account to make online payments that are secure, guaranteed, and confirmed immediately. Check this [page](https://stripe.com/docs/payments/bancontact) for more details."
    @type bancontact :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "BLIK is a [single use](https://stripe.com/docs/payments/payment-methods#usage) payment method that requires customers to authenticate their payments. When customers want to pay online using BLIK, they request a six-digit code from their banking application and enter it into the payment collection form. Check this [page](https://stripe.com/docs/payments/blik) for more details."
    @type blik :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Boleto is an official (regulated by the Central Bank of Brazil) payment method in Brazil. Check this [page](https://stripe.com/docs/payments/boleto) for more details."
    @type boleto :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Cards are a popular way for consumers and businesses to pay online or in person. Stripe supports global and local card networks."
    @type card :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Cartes Bancaires is France's local card network. More than 95% of these cards are co-branded with either Visa or Mastercard, meaning you can process these cards over either Cartes Bancaires or the Visa or Mastercard networks. Check this [page](https://stripe.com/docs/payments/cartes-bancaires) for more details."
    @type cartes_bancaires :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Cash App is a popular consumer app in the US that allows customers to bank, invest, send, and receive money using their digital wallet. Check this [page](https://stripe.com/docs/payments/cash-app-pay) for more details."
    @type cashapp :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Whether or not the payment method should be displayed."
    @type display_preference :: %{optional(:preference) => :none | :off | :on}
  )

  (
    @typedoc "EPS is an Austria-based payment method that allows customers to complete transactions online using their bank credentials. EPS is supported by all Austrian banks and is accepted by over 80% of Austrian online retailers. Check this [page](https://stripe.com/docs/payments/eps) for more details."
    @type eps :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Financial Process Exchange (FPX) is a Malaysia-based payment method that allows customers to complete transactions online using their bank credentials. Bank Negara Malaysia (BNM), the Central Bank of Malaysia, and eleven other major Malaysian financial institutions are members of the PayNet Group, which owns and operates FPX. It is one of the most popular online payment methods in Malaysia, with nearly 90 million transactions in 2018 according to BNM. Check this [page](https://stripe.com/docs/payments/fpx) for more details."
    @type fpx :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "giropay is a German payment method based on online banking, introduced in 2006. It allows customers to complete transactions online using their online banking environment, with funds debited from their bank account. Depending on their bank, customers confirm payments on giropay using a second factor of authentication or a PIN. giropay accounts for 10% of online checkouts in Germany. Check this [page](https://stripe.com/docs/payments/giropay) for more details."
    @type giropay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Google Pay allows customers to make payments in your app or website using any credit or debit card saved to their Google Account, including those from Google Play, YouTube, Chrome, or an Android device. Use the Google Pay API to request any credit or debit card stored in your customer's Google account. Check this [page](https://stripe.com/docs/google-pay) for more details."
    @type google_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "GrabPay is a payment method developed by [Grab](https://www.grab.com/sg/consumer/finance/pay/). GrabPay is a digital wallet - customers maintain a balance in their wallets that they pay out with. Check this [page](https://stripe.com/docs/payments/grabpay) for more details."
    @type grabpay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "iDEAL is a Netherlands-based payment method that allows customers to complete transactions online using their bank credentials. All major Dutch banks are members of Currence, the scheme that operates iDEAL, making it the most popular online payment method in the Netherlands with a share of online transactions close to 55%. Check this [page](https://stripe.com/docs/payments/ideal) for more details."
    @type ideal :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "JCB is a credit card company based in Japan. JCB is currently available in Japan to businesses approved by JCB, and available to all businesses in the US, Canada, Australia, New Zealand, UK, and Ireland. Check this [page](https://support.stripe.com/questions/accepting-japan-credit-bureau-%28jcb%29-payments) for more details."
    @type jcb :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Klarna gives customers a range of [payment options](https://stripe.com/docs/payments/klarna#payment-options) during checkout. Available payment options vary depending on the customer's billing address and the transaction amount. These payment options make it convenient for customers to purchase items in all price ranges. Check this [page](https://stripe.com/docs/payments/klarna) for more details."
    @type klarna :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Konbini allows customers in Japan to pay for bills and online purchases at convenience stores with cash. Check this [page](https://stripe.com/docs/payments/konbini) for more details."
    @type konbini :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "[Link](https://stripe.com/docs/payments/link) is a payment method network. With Link, users save their payment details once, then reuse that information to pay with one click for any business on the network."
    @type link :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "OXXO is a Mexican chain of convenience stores with thousands of locations across Latin America and represents nearly 20% of online transactions in Mexico. OXXO allows customers to pay bills and online purchases in-store with cash. Check this [page](https://stripe.com/docs/payments/oxxo) for more details."
    @type oxxo :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Przelewy24 is a Poland-based payment method aggregator that allows customers to complete transactions online using bank transfers and other methods. Bank transfers account for 30% of online payments in Poland and Przelewy24 provides a way for customers to pay with over 165 banks. Check this [page](https://stripe.com/docs/payments/p24) for more details."
    @type p24 :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "PayNow is a Singapore-based payment method that allows customers to make a payment using their preferred app from participating banks and participating non-bank financial institutions. Check this [page](https://stripe.com/docs/payments/paynow) for more details."
    @type paynow :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "PayPal, a digital wallet popular with customers in Europe, allows your customers worldwide to pay using their PayPal account. Check this [page](https://stripe.com/docs/payments/paypal) for more details."
    @type paypal :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "PromptPay is a Thailand-based payment method that allows customers to make a payment using their preferred app from participating banks. Check this [page](https://stripe.com/docs/payments/promptpay) for more details."
    @type promptpay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "The [Single Euro Payments Area (SEPA)](https://en.wikipedia.org/wiki/Single_Euro_Payments_Area) is an initiative of the European Union to simplify payments within and across member countries. SEPA established and enforced banking standards to allow for the direct debiting of every EUR-denominated bank account within the SEPA region, check this [page](https://stripe.com/docs/payments/sepa-debit) for more details."
    @type sepa_debit :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users in Europe and the United States can use the [Payment Intents API](https://stripe.com/docs/payments/payment-intents)—a single integration path for creating payments using any supported method—to accept [Sofort](https://www.sofort.com/) payments from customers. Check this [page](https://stripe.com/docs/payments/sofort) for more details."
    @type sofort :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users in the United States can accept ACH direct debit payments from customers with a US bank account using the Automated Clearing House (ACH) payments system operated by Nacha. Check this [page](https://stripe.com/docs/payments/ach-debit) for more details."
    @type us_bank_account :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "WeChat, owned by Tencent, is China's leading mobile app with over 1 billion monthly active users. Chinese consumers can use WeChat Pay to pay for goods and services inside of businesses' apps and websites. WeChat Pay users buy most frequently in gaming, e-commerce, travel, online education, and food/nutrition. Check this [page](https://stripe.com/docs/payments/wechat-pay) for more details."
    @type wechat_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    nil

    @doc "<p>List payment method configurations</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_method_configurations`\n"
    (
      @spec list(
              params :: %{
                optional(:application) => binary | binary,
                optional(:expand) => list(binary)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PaymentMethodConfiguration.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/payment_method_configurations", [], [])

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

    @doc "<p>Retrieve payment method configuration</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_method_configurations/{configuration}`\n"
    (
      @spec retrieve(
              configuration :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethodConfiguration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(configuration, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_method_configurations/{configuration}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "configuration",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "configuration",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [configuration]
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

    @doc "<p>Update payment method configuration</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_method_configurations/{configuration}`\n"
    (
      @spec update(
              configuration :: binary(),
              params :: %{
                optional(:fpx) => fpx,
                optional(:name) => binary,
                optional(:affirm) => affirm,
                optional(:acss_debit) => acss_debit,
                optional(:bacs_debit) => bacs_debit,
                optional(:alipay) => alipay,
                optional(:giropay) => giropay,
                optional(:ideal) => ideal,
                optional(:expand) => list(binary),
                optional(:card) => card,
                optional(:active) => boolean,
                optional(:link) => link,
                optional(:promptpay) => promptpay,
                optional(:cashapp) => cashapp,
                optional(:oxxo) => oxxo,
                optional(:us_bank_account) => us_bank_account,
                optional(:paypal) => paypal,
                optional(:boleto) => boleto,
                optional(:jcb) => jcb,
                optional(:konbini) => konbini,
                optional(:blik) => blik,
                optional(:wechat_pay) => wechat_pay,
                optional(:sofort) => sofort,
                optional(:apple_pay) => apple_pay,
                optional(:p24) => p24,
                optional(:google_pay) => google_pay,
                optional(:afterpay_clearpay) => afterpay_clearpay,
                optional(:cartes_bancaires) => cartes_bancaires,
                optional(:grabpay) => grabpay,
                optional(:apple_pay_later) => apple_pay_later,
                optional(:bancontact) => bancontact,
                optional(:au_becs_debit) => au_becs_debit,
                optional(:sepa_debit) => sepa_debit,
                optional(:klarna) => klarna,
                optional(:paynow) => paynow,
                optional(:eps) => eps
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethodConfiguration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(configuration, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_method_configurations/{configuration}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "configuration",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "configuration",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [configuration]
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

    @doc "<p>Creates a payment method configuration</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_method_configurations`\n"
    (
      @spec create(
              params :: %{
                optional(:fpx) => fpx,
                optional(:name) => binary,
                optional(:affirm) => affirm,
                optional(:acss_debit) => acss_debit,
                optional(:bacs_debit) => bacs_debit,
                optional(:alipay) => alipay,
                optional(:giropay) => giropay,
                optional(:ideal) => ideal,
                optional(:expand) => list(binary),
                optional(:card) => card,
                optional(:link) => link,
                optional(:promptpay) => promptpay,
                optional(:cashapp) => cashapp,
                optional(:oxxo) => oxxo,
                optional(:us_bank_account) => us_bank_account,
                optional(:paypal) => paypal,
                optional(:boleto) => boleto,
                optional(:jcb) => jcb,
                optional(:konbini) => konbini,
                optional(:blik) => blik,
                optional(:wechat_pay) => wechat_pay,
                optional(:sofort) => sofort,
                optional(:apple_pay) => apple_pay,
                optional(:p24) => p24,
                optional(:google_pay) => google_pay,
                optional(:afterpay_clearpay) => afterpay_clearpay,
                optional(:cartes_bancaires) => cartes_bancaires,
                optional(:grabpay) => grabpay,
                optional(:apple_pay_later) => apple_pay_later,
                optional(:parent) => binary,
                optional(:bancontact) => bancontact,
                optional(:au_becs_debit) => au_becs_debit,
                optional(:sepa_debit) => sepa_debit,
                optional(:klarna) => klarna,
                optional(:paynow) => paynow,
                optional(:eps) => eps
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethodConfiguration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/payment_method_configurations", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
