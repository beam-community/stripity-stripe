defmodule Stripe.Event do
  use Stripe.Entity

  @moduledoc "Events are our way of letting you know when something interesting happens in\nyour account. When an interesting event occurs, we create a new `Event`\nobject. For example, when a charge succeeds, we create a `charge.succeeded`\nevent, and when an invoice payment attempt fails, we create an\n`invoice.payment_failed` event. Certain API requests might create multiple\nevents. For example, if you create a new subscription for a\ncustomer, you receive both a `customer.subscription.created` event and a\n`charge.succeeded` event.\n\nEvents occur when the state of another API resource changes. The event's data\nfield embeds the resource's state at the time of the change. For\nexample, a `charge.succeeded` event contains a charge, and an\n`invoice.payment_failed` event contains an invoice.\n\nAs with other API resources, you can use endpoints to retrieve an\n[individual event](https://stripe.com/docs/api#retrieve_event) or a [list of events](https://stripe.com/docs/api#list_events)\nfrom the API. We also have a separate\n[webhooks](http://en.wikipedia.org/wiki/Webhook) system for sending the\n`Event` objects directly to an endpoint on your server. You can manage\nwebhooks in your\n[account settings](https://dashboard.stripe.com/account/webhooks). Learn how\nto [listen for events](https://docs.stripe.com/webhooks)\nso that your integration can automatically trigger reactions.\n\nWhen using [Connect](https://docs.stripe.com/connect), you can also receive event notifications\nthat occur in connected accounts. For these events, there's an\nadditional `account` attribute in the received `Event` object.\n\nWe only guarantee access to events through the [Retrieve Event API](https://stripe.com/docs/api#retrieve_event)\nfor 30 days."
  (
    defstruct [
      :account,
      :api_version,
      :created,
      :data,
      :id,
      :livemode,
      :object,
      :pending_webhooks,
      :request,
      :type
    ]

    @typedoc "The `event` type.\n\n  * `account` The connected account that originates the event.\n  * `api_version` The Stripe API version used to render `data`. This property is populated only for events on or after October 31, 2014.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `data` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `pending_webhooks` Number of webhooks that haven't been successfully delivered (for example, to return a 20x response) to the URLs you specify.\n  * `request` Information on the API request that triggers the event.\n  * `type` Description of the event (for example, `invoice.created` or `charge.refunded`).\n"
    @type t :: %__MODULE__{
            account: binary,
            api_version: binary | nil,
            created: integer,
            data: term,
            id: binary,
            livemode: boolean,
            object: binary,
            pending_webhooks: integer,
            request: term | nil,
            type: binary
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

    @doc "<p>List events, going back up to 30 days. Each event data is rendered according to Stripe API version at its creation time, specified in <a href=\"https://docs.stripe.com/api/events/object\">event object</a> <code>api_version</code> attribute (not according to your current Stripe API version or <code>Stripe-Version</code> header).</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/events`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:delivery_success) => boolean,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:type) => binary,
                optional(:types) => list(binary)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Event.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/events", [], [])

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

    @doc "<p>Retrieves the details of an event if it was created in the last 30 days. Supply the unique identifier of the event, which you might have received in a webhook.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/events/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Event.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/events/{id}",
            [
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
            [id]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
