# credo:disable-for-this-file
defmodule Stripe.Event do
  use Stripe.Entity

  @moduledoc "Snapshot events allow you to track and react to activity in your Stripe integration. When\nthe state of another API resource changes, Stripe creates an `Event` object that contains\nall the relevant information associated with that action, including the affected API\nresource. For example, a successful payment triggers a `charge.succeeded` event, which\ncontains the `Charge` in the event's data property. Some actions trigger multiple events.\nFor example, if you create a new subscription for a customer, it triggers both a\n`customer.subscription.created` event and a `charge.succeeded` event.\n\nConfigure an event destination in your account to listen for events that represent actions\nyour integration needs to respond to. Additionally, you can retrieve an individual event or\na list of events from the API.\n\n[Connect](https://docs.stripe.com/connect) platforms can also receive event notifications\nthat occur in their connected accounts. These events include an account attribute that\nidentifies the relevant connected account.\n\nYou can access events through the [Retrieve Event API](https://docs.stripe.com/api/events#retrieve_event)\nfor 30 days."
  (
    defstruct [
      :account,
      :api_version,
      :context,
      :created,
      :data,
      :id,
      :livemode,
      :object,
      :pending_webhooks,
      :request,
      :type
    ]

    @typedoc "The `event` type.\n\n  * `account` The connected account that originates the event.\n  * `api_version` The Stripe API version used to render `data` when the event was created. The contents of `data` never change, so this value remains static regardless of the API version currently in use. This property is populated only for events created on or after October 31, 2014.\n  * `context` Authentication context needed to fetch the event or related object.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `data` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `pending_webhooks` Number of webhooks that haven't been successfully delivered (for example, to return a 20x response) to the URLs you specify.\n  * `request` Information on the API request that triggers the event.\n  * `type` Description of the event (for example, `invoice.created` or `charge.refunded`).\n"
    @type t :: %__MODULE__{
            account: binary,
            api_version: binary | nil,
            context: binary,
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
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "id",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "id",
                  properties: [],
                  title: nil,
                  type: "string"
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