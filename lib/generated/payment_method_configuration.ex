# credo:disable-for-this-file
defmodule Stripe.PaymentMethodConfiguration do
  use Stripe.Entity

  @moduledoc "PaymentMethodConfigurations control which payment methods are displayed to your customers when you don't explicitly specify payment method types. You can have multiple configurations with different sets of payment methods for different scenarios.\n\nThere are two types of PaymentMethodConfigurations. Which is used depends on the [charge type](https://stripe.com/docs/connect/charges):\n\n**Direct** configurations apply to payments created on your account, including Connect destination charges, Connect separate charges and transfers, and payments not involving Connect.\n\n**Child** configurations apply to payments created on your connected accounts using direct charges, and charges with the on_behalf_of parameter.\n\nChild configurations have a `parent` that sets default values and controls which settings connected accounts may override. You can specify a parent ID at payment time, and Stripe will automatically resolve the connected account’s associated child configuration. Parent configurations are [managed in the dashboard](https://dashboard.stripe.com/settings/payment_methods/connected_accounts) and are not available in this API.\n\nRelated guides:\n- [Payment Method Configurations API](https://stripe.com/docs/connect/payment-method-configurations)\n- [Multiple configurations on dynamic payment methods](https://stripe.com/docs/payments/multiple-payment-method-configs)\n- [Multiple configurations for your Connect accounts](https://stripe.com/docs/connect/multiple-payment-method-configurations)"
  (
    defstruct [
      :zip,
      :swish,
      :us_bank_account,
      :payco,
      :afterpay_clearpay,
      :sepa_debit,
      :cashapp,
      :kakao_pay,
      :livemode,
      :samsung_pay,
      :promptpay,
      :wechat_pay,
      :alma,
      :paynow,
      :oxxo,
      :google_pay,
      :fpx,
      :paypal,
      :application,
      :cartes_bancaires,
      :p24,
      :blik,
      :konbini,
      :kr_card,
      :link,
      :acss_debit,
      :is_default,
      :name,
      :id,
      :crypto,
      :naver_pay,
      :twint,
      :mb_way,
      :card,
      :apple_pay,
      :klarna,
      :revolut_pay,
      :multibanco,
      :giropay,
      :object,
      :pix,
      :ideal,
      :billie,
      :eps,
      :grabpay,
      :jcb,
      :nz_bank_account,
      :pay_by_bank,
      :mobilepay,
      :affirm,
      :bacs_debit,
      :bancontact,
      :active,
      :parent,
      :amazon_pay,
      :au_becs_debit,
      :alipay,
      :boleto,
      :satispay,
      :customer_balance,
      :sofort
    ]

    @typedoc "The `payment_method_configuration` type.\n\n  * `acss_debit` \n  * `active` Whether the configuration can be used for new payments.\n  * `affirm` \n  * `afterpay_clearpay` \n  * `alipay` \n  * `alma` \n  * `amazon_pay` \n  * `apple_pay` \n  * `application` For child configs, the Connect application associated with the configuration.\n  * `au_becs_debit` \n  * `bacs_debit` \n  * `bancontact` \n  * `billie` \n  * `blik` \n  * `boleto` \n  * `card` \n  * `cartes_bancaires` \n  * `cashapp` \n  * `crypto` \n  * `customer_balance` \n  * `eps` \n  * `fpx` \n  * `giropay` \n  * `google_pay` \n  * `grabpay` \n  * `id` Unique identifier for the object.\n  * `ideal` \n  * `is_default` The default configuration is used whenever a payment method configuration is not specified.\n  * `jcb` \n  * `kakao_pay` \n  * `klarna` \n  * `konbini` \n  * `kr_card` \n  * `link` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `mb_way` \n  * `mobilepay` \n  * `multibanco` \n  * `name` The configuration's name.\n  * `naver_pay` \n  * `nz_bank_account` \n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `oxxo` \n  * `p24` \n  * `parent` For child configs, the configuration's parent configuration.\n  * `pay_by_bank` \n  * `payco` \n  * `paynow` \n  * `paypal` \n  * `pix` \n  * `promptpay` \n  * `revolut_pay` \n  * `samsung_pay` \n  * `satispay` \n  * `sepa_debit` \n  * `sofort` \n  * `swish` \n  * `twint` \n  * `us_bank_account` \n  * `wechat_pay` \n  * `zip` \n"
    @type t :: %__MODULE__{
            acss_debit: term,
            active: boolean,
            affirm: term,
            afterpay_clearpay: term,
            alipay: term,
            alma: term,
            amazon_pay: term,
            apple_pay: term,
            application: binary | nil,
            au_becs_debit: term,
            bacs_debit: term,
            bancontact: term,
            billie: term,
            blik: term,
            boleto: term,
            card: term,
            cartes_bancaires: term,
            cashapp: term,
            crypto: term,
            customer_balance: term,
            eps: term,
            fpx: term,
            giropay: term,
            google_pay: term,
            grabpay: term,
            id: binary,
            ideal: term,
            is_default: boolean,
            jcb: term,
            kakao_pay: term,
            klarna: term,
            konbini: term,
            kr_card: term,
            link: term,
            livemode: boolean,
            mb_way: term,
            mobilepay: term,
            multibanco: term,
            name: binary,
            naver_pay: term,
            nz_bank_account: term,
            object: binary,
            oxxo: term,
            p24: term,
            parent: binary | nil,
            pay_by_bank: term,
            payco: term,
            paynow: term,
            paypal: term,
            pix: term,
            promptpay: term,
            revolut_pay: term,
            samsung_pay: term,
            satispay: term,
            sepa_debit: term,
            sofort: term,
            swish: term,
            twint: term,
            us_bank_account: term,
            wechat_pay: term,
            zip: term
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
    @typedoc "Alma is a Buy Now, Pay Later payment method that offers customers the ability to pay in 2, 3, or 4 installments."
    @type alma :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Amazon Pay is a wallet payment method that lets your customers check out the same way as on Amazon."
    @type amazon_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users can accept [Apple Pay](https://stripe.com/payments/apple-pay) in iOS applications in iOS 9 and later, and on the web in Safari starting with iOS 10 or macOS Sierra. There are no additional fees to process Apple Pay payments, and the [pricing](https://stripe.com/pricing) is the same as other card transactions. Check this [page](https://stripe.com/docs/apple-pay) for more details."
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
    @typedoc "Billie is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) payment method that offers businesses Pay by Invoice where they offer payment terms ranging from 7-120 days. Customers are redirected from your website or app, authorize the payment with Billie, then return to your website or app. You get [immediate notification](/payments/payment-methods#payment-notification) of whether the payment succeeded or failed."
    @type billie :: %{optional(:display_preference) => display_preference}
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
    @typedoc "[Stablecoin payments](https://stripe.com/docs/payments/stablecoin-payments) enable customers to pay in stablecoins like USDC from 100s of wallets including Phantom and Metamask."
    @type crypto :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Uses a customer’s [cash balance](https://stripe.com/docs/payments/customer-balance) for the payment. The cash balance can be funded via a bank transfer. Check this [page](https://stripe.com/docs/payments/bank-transfers) for more details."
    @type customer_balance :: %{optional(:display_preference) => display_preference}
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
    @typedoc "Meal vouchers in France, or “titres-restaurant”, is a local benefits program commonly offered by employers for their employees to purchase prepared food and beverages on working days. Check this [page](https://stripe.com/docs/payments/benefits/fr-meal-vouchers) for more details."
    @type fr_meal_voucher_conecs :: %{optional(:display_preference) => display_preference}
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
    @typedoc "JCB is a credit card company based in Japan. JCB is currently available in Japan to businesses approved by JCB, and available to all businesses in Australia, Canada, Hong Kong, Japan, New Zealand, Singapore, Switzerland, United Kingdom, United States, and all countries in the European Economic Area except Iceland. Check this [page](https://support.stripe.com/questions/accepting-japan-credit-bureau-%28jcb%29-payments) for more details."
    @type jcb :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Kakao Pay is a popular local wallet available in South Korea."
    @type kakao_pay :: %{optional(:display_preference) => display_preference}
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
    @typedoc "Korean cards let users pay using locally issued cards from South Korea."
    @type kr_card :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "[Link](https://stripe.com/docs/payments/link) is a payment method network. With Link, users save their payment details once, then reuse that information to pay with one click for any business on the network."
    @type link :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "MB WAY is the most popular wallet in Portugal. After entering their phone number in your checkout, customers approve the payment directly in their MB WAY app. Check this [page](https://stripe.com/docs/payments/mb-way) for more details."
    @type mb_way :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "MobilePay is a [single-use](https://stripe.com/docs/payments/payment-methods#usage) card wallet payment method used in Denmark and Finland. It allows customers to [authenticate and approve](https://stripe.com/docs/payments/payment-methods#customer-actions) payments using the MobilePay app. Check this [page](https://stripe.com/docs/payments/mobilepay) for more details."
    @type mobilepay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users in Europe and the United States can accept Multibanco payments from customers in Portugal using [Sources](https://stripe.com/docs/sources)—a single integration path for creating payments using any supported method."
    @type multibanco :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Naver Pay is a popular local wallet available in South Korea."
    @type naver_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users in New Zealand can accept Bulk Electronic Clearing System (BECS) direct debit payments from customers with a New Zeland bank account. Check this [page](https://stripe.com/docs/payments/nz-bank-account) for more details."
    @type nz_bank_account :: %{optional(:display_preference) => display_preference}
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
    @typedoc "Pay by bank is a redirect payment method backed by bank transfers. A customer is redirected to their bank to authorize a bank transfer for a given amount. This removes a lot of the error risks inherent in waiting for the customer to initiate a transfer themselves, and is less expensive than card payments."
    @type pay_by_bank :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "PAYCO is a [single-use](https://docs.stripe.com/payments/payment-methods#usage local wallet available in South Korea."
    @type payco :: %{optional(:display_preference) => display_preference}
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
    @typedoc "Pix is a payment method popular in Brazil. When paying with Pix, customers authenticate and approve payments by scanning a QR code in their preferred banking app. Check this [page](https://docs.stripe.com/payments/pix) for more details."
    @type pix :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "PromptPay is a Thailand-based payment method that allows customers to make a payment using their preferred app from participating banks. Check this [page](https://stripe.com/docs/payments/promptpay) for more details."
    @type promptpay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Revolut Pay, developed by Revolut, a global finance app, is a digital wallet payment method. Revolut Pay uses the customer’s stored balance or cards to fund the payment, and offers the option for non-Revolut customers to save their details after their first purchase."
    @type revolut_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Samsung Pay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage local wallet available in South Korea."
    @type samsung_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Satispay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) payment method where customers are required to [authenticate](/payments/payment-methods#customer-actions) their payment. Customers pay by being redirected from your website or app, authorizing the payment with Satispay, then returning to your website or app. You get [immediate notification](/payments/payment-methods#payment-notification) of whether the payment succeeded or failed."
    @type satispay :: %{optional(:display_preference) => display_preference}
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
    @typedoc "Swish is a [real-time](https://stripe.com/docs/payments/real-time) payment method popular in Sweden. It allows customers to [authenticate and approve](https://stripe.com/docs/payments/payment-methods#customer-actions) payments using the Swish mobile app and the Swedish BankID mobile app. Check this [page](https://stripe.com/docs/payments/swish) for more details."
    @type swish :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Twint is a payment method popular in Switzerland. It allows customers to pay using their mobile phone. Check this [page](https://docs.stripe.com/payments/twint) for more details."
    @type twint :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Stripe users in the United States can accept ACH direct debit payments from customers with a US bank account using the Automated Clearing House (ACH) payments system operated by Nacha. Check this [page](https://stripe.com/docs/payments/ach-direct-debit) for more details."
    @type us_bank_account :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "WeChat, owned by Tencent, is China's leading mobile app with over 1 billion monthly active users. Chinese consumers can use WeChat Pay to pay for goods and services inside of businesses' apps and websites. WeChat Pay users buy most frequently in gaming, e-commerce, travel, online education, and food/nutrition. Check this [page](https://stripe.com/docs/payments/wechat-pay) for more details."
    @type wechat_pay :: %{optional(:display_preference) => display_preference}
  )

  (
    @typedoc "Zip gives your customers a way to split purchases over a series of payments. Check this [page](https://stripe.com/docs/payments/zip) for more details like country availability."
    @type zip :: %{optional(:display_preference) => display_preference}
  )

  (
    nil

    @doc "<p>List payment method configurations</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_method_configurations`\n"
    (
      @spec list(
              params :: %{
                optional(:application) => binary | binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
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
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "configuration",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "configuration",
                  properties: [],
                  title: nil,
                  type: "string"
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

    @doc "<p>Creates a payment method configuration</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_method_configurations`\n"
    (
      @spec create(
              params :: %{
                optional(:sofort) => sofort,
                optional(:customer_balance) => customer_balance,
                optional(:satispay) => satispay,
                optional(:boleto) => boleto,
                optional(:alipay) => alipay,
                optional(:au_becs_debit) => au_becs_debit,
                optional(:amazon_pay) => amazon_pay,
                optional(:parent) => binary,
                optional(:bancontact) => bancontact,
                optional(:bacs_debit) => bacs_debit,
                optional(:affirm) => affirm,
                optional(:mobilepay) => mobilepay,
                optional(:pay_by_bank) => pay_by_bank,
                optional(:nz_bank_account) => nz_bank_account,
                optional(:jcb) => jcb,
                optional(:grabpay) => grabpay,
                optional(:eps) => eps,
                optional(:billie) => billie,
                optional(:ideal) => ideal,
                optional(:pix) => pix,
                optional(:giropay) => giropay,
                optional(:multibanco) => multibanco,
                optional(:revolut_pay) => revolut_pay,
                optional(:klarna) => klarna,
                optional(:apple_pay) => apple_pay,
                optional(:card) => card,
                optional(:mb_way) => mb_way,
                optional(:twint) => twint,
                optional(:naver_pay) => naver_pay,
                optional(:crypto) => crypto,
                optional(:name) => binary,
                optional(:acss_debit) => acss_debit,
                optional(:link) => link,
                optional(:kr_card) => kr_card,
                optional(:konbini) => konbini,
                optional(:blik) => blik,
                optional(:p24) => p24,
                optional(:cartes_bancaires) => cartes_bancaires,
                optional(:paypal) => paypal,
                optional(:fpx) => fpx,
                optional(:google_pay) => google_pay,
                optional(:oxxo) => oxxo,
                optional(:paynow) => paynow,
                optional(:alma) => alma,
                optional(:wechat_pay) => wechat_pay,
                optional(:promptpay) => promptpay,
                optional(:fr_meal_voucher_conecs) => fr_meal_voucher_conecs,
                optional(:samsung_pay) => samsung_pay,
                optional(:kakao_pay) => kakao_pay,
                optional(:expand) => list(binary),
                optional(:cashapp) => cashapp,
                optional(:apple_pay_later) => apple_pay_later,
                optional(:sepa_debit) => sepa_debit,
                optional(:afterpay_clearpay) => afterpay_clearpay,
                optional(:payco) => payco,
                optional(:us_bank_account) => us_bank_account,
                optional(:swish) => swish,
                optional(:zip) => zip
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

  (
    nil

    @doc "<p>Update payment method configuration</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_method_configurations/{configuration}`\n"
    (
      @spec update(
              configuration :: binary(),
              params :: %{
                optional(:sofort) => sofort,
                optional(:customer_balance) => customer_balance,
                optional(:satispay) => satispay,
                optional(:boleto) => boleto,
                optional(:alipay) => alipay,
                optional(:au_becs_debit) => au_becs_debit,
                optional(:amazon_pay) => amazon_pay,
                optional(:active) => boolean,
                optional(:bancontact) => bancontact,
                optional(:bacs_debit) => bacs_debit,
                optional(:affirm) => affirm,
                optional(:mobilepay) => mobilepay,
                optional(:pay_by_bank) => pay_by_bank,
                optional(:nz_bank_account) => nz_bank_account,
                optional(:jcb) => jcb,
                optional(:grabpay) => grabpay,
                optional(:eps) => eps,
                optional(:billie) => billie,
                optional(:ideal) => ideal,
                optional(:pix) => pix,
                optional(:giropay) => giropay,
                optional(:multibanco) => multibanco,
                optional(:revolut_pay) => revolut_pay,
                optional(:klarna) => klarna,
                optional(:apple_pay) => apple_pay,
                optional(:card) => card,
                optional(:mb_way) => mb_way,
                optional(:twint) => twint,
                optional(:naver_pay) => naver_pay,
                optional(:crypto) => crypto,
                optional(:name) => binary,
                optional(:acss_debit) => acss_debit,
                optional(:link) => link,
                optional(:kr_card) => kr_card,
                optional(:konbini) => konbini,
                optional(:blik) => blik,
                optional(:p24) => p24,
                optional(:cartes_bancaires) => cartes_bancaires,
                optional(:paypal) => paypal,
                optional(:fpx) => fpx,
                optional(:google_pay) => google_pay,
                optional(:oxxo) => oxxo,
                optional(:paynow) => paynow,
                optional(:alma) => alma,
                optional(:wechat_pay) => wechat_pay,
                optional(:promptpay) => promptpay,
                optional(:fr_meal_voucher_conecs) => fr_meal_voucher_conecs,
                optional(:samsung_pay) => samsung_pay,
                optional(:kakao_pay) => kakao_pay,
                optional(:expand) => list(binary),
                optional(:cashapp) => cashapp,
                optional(:apple_pay_later) => apple_pay_later,
                optional(:sepa_debit) => sepa_debit,
                optional(:afterpay_clearpay) => afterpay_clearpay,
                optional(:payco) => payco,
                optional(:us_bank_account) => us_bank_account,
                optional(:swish) => swish,
                optional(:zip) => zip
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
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "configuration",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "configuration",
                  properties: [],
                  title: nil,
                  type: "string"
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
end
