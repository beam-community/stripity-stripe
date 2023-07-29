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
      :livemode,
      :location,
      :metadata,
      :object,
      :serial_number,
      :status
    ]

    @typedoc "The `terminal.reader` type.\n\n  * `action` The most recent action performed by the reader.\n  * `device_sw_version` The current software version of the reader.\n  * `device_type` Type of reader, one of `bbpos_wisepad3`, `stripe_m2`, `bbpos_chipper2x`, `bbpos_wisepos_e`, `verifone_P400`, or `simulated_wisepos_e`.\n  * `id` Unique identifier for the object.\n  * `ip_address` The local IP address of the reader.\n  * `label` Custom label given to the reader for easier identification.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `location` The location identifier of the reader.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `serial_number` Serial number of the reader.\n  * `status` The networking status of the reader.\n"
    @type t :: %__MODULE__{
            action: term | nil,
            device_sw_version: binary | nil,
            device_type: binary,
            id: binary,
            ip_address: binary | nil,
            label: binary,
            livemode: boolean,
            location: (binary | Stripe.Terminal.Location.t()) | nil,
            metadata: term,
            object: binary,
            serial_number: binary,
            status: binary | nil
          }
  )

  (
    @typedoc "Simulated data for the card_present payment method."
    @type card_present :: %{optional(:number) => binary}
  )

  (
    @typedoc "Cart"
    @type cart :: %{
            optional(:currency) => binary,
            optional(:line_items) => list(line_items),
            optional(:tax) => integer,
            optional(:total) => integer
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
    @typedoc "Configuration overrides"
    @type process_config :: %{optional(:skip_tipping) => boolean, optional(:tipping) => tipping}
  )

  (
    @typedoc "Tipping configuration for this transaction."
    @type tipping :: %{optional(:amount_eligible) => integer}
  )

  (
    nil

    @doc "<p>Updates a <code>Reader</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}`\n"
    (
      @spec update(
              reader :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:label) => binary,
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Returns a list of <code>Reader</code> objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/terminal/readers`\n"
    (
      @spec list(
              params :: %{
                optional(:device_type) =>
                  :bbpos_chipper2x
                  | :bbpos_wisepad3
                  | :bbpos_wisepos_e
                  | :simulated_wisepos_e
                  | :stripe_m2
                  | :verifone_P400,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:location) => binary,
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Initiates a payment flow on a Reader.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/process_payment_intent`\n"
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Initiates a setup intent flow on a Reader.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/process_setup_intent`\n"
    (
      @spec process_setup_intent(
              reader :: binary(),
              params :: %{
                optional(:customer_consent_collected) => boolean,
                optional(:expand) => list(binary),
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Cancels the current reader action.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/cancel_action`\n"
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Sets reader display to show cart details.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/set_reader_display`\n"
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Initiates a refund on a Reader</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/readers/{reader}/refund_payment`\n"
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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
                optional(:card_present) => card_present,
                optional(:expand) => list(binary),
                optional(:interac_present) => interac_present,
                optional(:type) => :card_present | :interac_present
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "reader",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "reader",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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
