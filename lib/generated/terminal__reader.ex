defmodule Stripe.Terminal.Reader do
  use Stripe.Entity

  @moduledoc "A Reader represents a physical device for accepting payment details.\n\nRelated guide: [Connecting to a reader](https://stripe.com/docs/terminal/payments/connect-reader)"
  (
    defstruct [
      :action,
      :device_sw_version,
      :device_type,
      :id,
      :ip_address,
      :label,
      :last_seen_at,
      :livemode,
      :location,
      :metadata,
      :object,
      :serial_number,
      :status
    ]

    @typedoc "The `terminal.reader` type.\n\n  * `action` The most recent action performed by the reader.\n  * `device_sw_version` The current software version of the reader.\n  * `device_type` Device type of the reader.\n  * `id` Unique identifier for the object.\n  * `ip_address` The local IP address of the reader.\n  * `label` Custom label given to the reader for easier identification.\n  * `last_seen_at` The last time this reader reported to Stripe backend.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `location` The location identifier of the reader.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `serial_number` Serial number of the reader.\n  * `status` The networking status of the reader. We do not recommend using this field in flows that may block taking payments.\n"
    @type t :: %__MODULE__{
            action: term | nil,
            device_sw_version: binary | nil,
            device_type: binary,
            id: binary,
            ip_address: binary | nil,
            label: binary,
            last_seen_at: integer | nil,
            livemode: boolean,
            location: (binary | Stripe.Terminal.Location.t()) | nil,
            metadata: term,
            object: binary,
            serial_number: binary,
            status: binary | nil
          }
  )

  (
    @typedoc "Simulated data for the card payment method."
    @type card :: %{
            optional(:cvc) => binary,
            optional(:exp_month) => integer,
            optional(:exp_year) => integer,
            optional(:number) => binary
          }
  )

  (
    @typedoc "Simulated data for the card_present payment method."
    @type card_present :: %{optional(:number) => binary}
  )

  (
    @typedoc "Cart details to display on the reader screen, including line items, amounts, and currency."
    @type cart :: %{
            optional(:currency) => binary,
            optional(:line_items) => list(line_items),
            optional(:tax) => integer,
            optional(:total) => integer
          }
  )

  (
    @typedoc nil
    @type choices :: %{
            optional(:id) => binary,
            optional(:style) => :primary | :secondary,
            optional(:text) => binary
          }
  )

  (
    @typedoc "Configuration overrides for this collection, such as tipping, surcharging, and customer cancellation settings."
    @type collect_config :: %{
            optional(:allow_redisplay) => :always | :limited | :unspecified,
            optional(:enable_customer_cancellation) => boolean,
            optional(:skip_tipping) => boolean,
            optional(:tipping) => tipping
          }
  )

  (
    @typedoc "Configuration overrides for this confirmation, such as surcharge settings and return URL."
    @type confirm_config :: %{optional(:return_url) => binary}
  )

  (
    @typedoc "Customize the text which will be displayed while collecting this input"
    @type custom_text :: %{
            optional(:description) => binary,
            optional(:skip_button) => binary,
            optional(:submit_button) => binary,
            optional(:title) => binary
          }
  )

  (
    @typedoc nil
    @type inputs :: %{
            optional(:custom_text) => custom_text,
            optional(:required) => boolean,
            optional(:selection) => selection,
            optional(:toggles) => list(toggles),
            optional(:type) => :email | :numeric | :phone | :selection | :signature | :text
          }
  )

  (
    @typedoc "Simulated data for the interac_present payment method."
    @type interac_present :: %{optional(:number) => binary}
  )

  (
    @typedoc nil
    @type line_items :: %{
            optional(:amount) => integer,
            optional(:description) => binary,
            optional(:quantity) => integer
          }
  )

  (
    @typedoc "Configuration overrides for this transaction, such as tipping and customer cancellation settings."
    @type process_config :: %{
            optional(:allow_redisplay) => :always | :limited | :unspecified,
            optional(:enable_customer_cancellation) => boolean,
            optional(:return_url) => binary,
            optional(:skip_tipping) => boolean,
            optional(:tipping) => tipping
          }
  )

  (
    @typedoc "Configuration overrides for this refund, such as customer cancellation settings."
    @type refund_payment_config :: %{optional(:enable_customer_cancellation) => boolean}
  )

  (
    @typedoc "Options for the `selection` input"
    @type selection :: %{optional(:choices) => list(choices)}
  )

  (
    @typedoc "Tipping configuration for this transaction."
    @type tipping :: %{optional(:amount_eligible) => integer}
  )

  (
    @typedoc nil
    @type toggles :: %{
            optional(:default_value) => :disabled | :enabled,
            optional(:description) => binary,
            optional(:title) => binary
          }
  )

  (
    nil

    @doc "<p>Deletes a <code>Reader</code> object.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/terminal/readers/{reader}`\n"
    (
      @spec delete(reader :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedTerminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(reader, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Returns a list of <code>Reader</code> objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/terminal/readers`\n"
    (
      @spec list(
              params :: %{
                optional(:device_type) =>
                  :bbpos_chipper2x
                  | :bbpos_wisepad3
                  | :bbpos_wisepos_e
                  | :mobile_phone_reader
                  | :simulated_stripe_s700
                  | :simulated_wisepos_e
                  | :stripe_m2
                  | :stripe_s700
                  | :verifone_P400,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:location) => binary,
                optional(:serial_number) => binary,
                optional(:starting_after) => binary,
                optional(:status) => :offline | :online
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Terminal.Reader.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/readers", [], [])

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

    @doc "<p>Retrieves a <code>Reader</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/terminal/readers/{reader}`\n"
    (
      @spec retrieve(
              reader :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t() | Stripe.DeletedTerminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Creates a new <code>Reader</code> object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:label) => binary,
                optional(:location) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:registration_code) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/readers", [], [])

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

    @doc "<p>Updates a <code>Reader</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}`\n"
    (
      @spec update(
              reader :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:label) => binary | binary,
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t() | Stripe.DeletedTerminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Cancels the current reader action. See <a href=\"/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven#programmatic-cancellation\">Programmatic Cancellation</a> for more details.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/cancel_action`\n"
    (
      @spec cancel_action(
              reader :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def cancel_action(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/cancel_action",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Initiates an <a href=\"/docs/terminal/features/collect-inputs\">input collection flow</a> on a Reader to display input forms and collect information from your customers.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/collect_inputs`\n"
    (
      @spec collect_inputs(
              reader :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:inputs) => list(inputs),
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def collect_inputs(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/collect_inputs",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Initiates a payment flow on a Reader and updates the PaymentIntent with card details before manual confirmation. See <a href=\"/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=inspect#collect-a-paymentmethod\">Collecting a Payment method</a> for more details.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/collect_payment_method`\n"
    (
      @spec collect_payment_method(
              reader :: binary(),
              params :: %{
                optional(:collect_config) => collect_config,
                optional(:expand) => list(binary),
                optional(:payment_intent) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def collect_payment_method(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/collect_payment_method",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Finalizes a payment on a Reader. See <a href=\"/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=inspect#confirm-the-paymentintent\">Confirming a Payment</a> for more details.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/confirm_payment_intent`\n"
    (
      @spec confirm_payment_intent(
              reader :: binary(),
              params :: %{
                optional(:confirm_config) => confirm_config,
                optional(:expand) => list(binary),
                optional(:payment_intent) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def confirm_payment_intent(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/confirm_payment_intent",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Initiates a payment flow on a Reader. See <a href=\"/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=immediately#process-payment\">process the payment</a> for more details.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/process_payment_intent`\n"
    (
      @spec process_payment_intent(
              reader :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:payment_intent) => binary,
                optional(:process_config) => process_config
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def process_payment_intent(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/process_payment_intent",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Initiates a SetupIntent flow on a Reader. See <a href=\"/docs/terminal/features/saving-payment-details/save-directly\">Save directly without charging</a> for more details.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/process_setup_intent`\n"
    (
      @spec process_setup_intent(
              reader :: binary(),
              params :: %{
                optional(:allow_redisplay) => :always | :limited | :unspecified,
                optional(:expand) => list(binary),
                optional(:process_config) => process_config,
                optional(:setup_intent) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def process_setup_intent(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/process_setup_intent",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Initiates an in-person refund on a Reader. See <a href=\"/docs/terminal/payments/regional?integration-country=CA#refund-an-interac-payment\">Refund an Interac Payment</a> for more details.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/refund_payment`\n"
    (
      @spec refund_payment(
              reader :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:charge) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:payment_intent) => binary,
                optional(:refund_application_fee) => boolean,
                optional(:refund_payment_config) => refund_payment_config,
                optional(:reverse_transfer) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def refund_payment(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/refund_payment",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Sets the reader display to show <a href=\"/docs/terminal/features/display\">cart details</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/set_reader_display`\n"
    (
      @spec set_reader_display(
              reader :: binary(),
              params :: %{
                optional(:cart) => cart,
                optional(:expand) => list(binary),
                optional(:type) => :cart
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def set_reader_display(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/readers/{reader}/set_reader_display",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Presents a payment method on a simulated reader. Can be used to simulate accepting a payment, saving a card or refunding a transaction.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/terminal/readers/{reader}/present_payment_method`\n"
    (
      @spec present_payment_method(
              reader :: binary(),
              params :: %{
                optional(:amount_tip) => integer,
                optional(:card) => card,
                optional(:card_present) => card_present,
                optional(:expand) => list(binary),
                optional(:interac_present) => interac_present,
                optional(:type) => :card | :card_present | :interac_present
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def present_payment_method(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/terminal/readers/{reader}/present_payment_method",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Use this endpoint to trigger a successful input collection on a simulated reader.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/terminal/readers/{reader}/succeed_input_collection`\n"
    (
      @spec succeed_input_collection(
              reader :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:skip_non_required_inputs) => :all | :none
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def succeed_input_collection(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/terminal/readers/{reader}/succeed_input_collection",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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

    @doc "<p>Use this endpoint to complete an input collection with a timeout error on a simulated reader.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/terminal/readers/{reader}/timeout_input_collection`\n"
    (
      @spec timeout_input_collection(
              reader :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Reader.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def timeout_input_collection(reader, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/terminal/readers/{reader}/timeout_input_collection",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "reader",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "reader",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [reader]
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