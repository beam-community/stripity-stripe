defmodule Stripe.Review do
  use Stripe.Entity

  @moduledoc "Reviews can be used to supplement automated fraud detection with human expertise.\n\nLearn more about [Radar](/radar) and reviewing payments\n[here](https://stripe.com/docs/radar/reviews)."
  (
    defstruct [
      :billing_zip,
      :charge,
      :closed_reason,
      :created,
      :id,
      :ip_address,
      :ip_address_location,
      :livemode,
      :object,
      :open,
      :opened_reason,
      :payment_intent,
      :reason,
      :session
    ]

    @typedoc "The `review` type.\n\n  * `billing_zip` The ZIP or postal code of the card used, if applicable.\n  * `charge` The charge associated with this review.\n  * `closed_reason` The reason the review was closed, or null if it has not yet been closed. One of `approved`, `refunded`, `refunded_as_fraud`, `disputed`, or `redacted`.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `id` Unique identifier for the object.\n  * `ip_address` The IP address where the payment originated.\n  * `ip_address_location` Information related to the location of the payment. Note that this information is an approximation and attempts to locate the nearest population center - it should not be used to determine a specific address.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `open` If `true`, the review needs action.\n  * `opened_reason` The reason the review was opened. One of `rule` or `manual`.\n  * `payment_intent` The PaymentIntent ID associated with this review, if one exists.\n  * `reason` The reason the review is currently open or closed. One of `rule`, `manual`, `approved`, `refunded`, `refunded_as_fraud`, `disputed`, or `redacted`.\n  * `session` Information related to the browsing session of the user who initiated the payment.\n"
    @type t :: %__MODULE__{
            billing_zip: binary | nil,
            charge: (binary | Stripe.Charge.t()) | nil,
            closed_reason: binary | nil,
            created: integer,
            id: binary,
            ip_address: binary | nil,
            ip_address_location: term | nil,
            livemode: boolean,
            object: binary,
            open: boolean,
            opened_reason: binary,
            payment_intent: binary | Stripe.PaymentIntent.t(),
            reason: binary,
            session: term | nil
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
    nil

    @doc "<p>Returns a list of <code>Review</code> objects that have <code>open</code> set to <code>true</code>. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/reviews`\n"
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
              {:ok, Stripe.List.t(Stripe.Review.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/reviews", [], [])

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

    @doc "<p>Retrieves a <code>Review</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/reviews/{review}`\n"
    (
      @spec retrieve(
              review :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Review.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(review, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/reviews/{review}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "review",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "review",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [review]
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

    @doc "<p>Approves a <code>Review</code> object, closing it and removing it from the list of reviews.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/reviews/{review}/approve`\n"
    (
      @spec approve(
              review :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Review.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def approve(review, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/reviews/{review}/approve",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "review",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "review",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [review]
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