defmodule Stripe.Radar.ValueListItem do
  use Stripe.Entity

  @moduledoc "Value list items allow you to add specific values to a given Radar value list, which can then be used in rules.\n\nRelated guide: [Managing list items](https://stripe.com/docs/radar/lists#managing-list-items)"
  (
    defstruct [:created, :created_by, :id, :livemode, :object, :value, :value_list]

    @typedoc "The `radar.value_list_item` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `created_by` The name or email address of the user who added this item to the value list.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `value` The value of the item.\n  * `value_list` The identifier of the value list this item belongs to.\n"
    @type t :: %__MODULE__{
            created: integer,
            created_by: binary,
            id: binary,
            livemode: boolean,
            object: binary,
            value: binary,
            value_list: binary
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

    @doc "<p>Returns a list of <code>ValueListItem</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/radar/value_list_items`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:value) => binary,
                optional(:value_list) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Radar.ValueListItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/radar/value_list_items", [], [])

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

    @doc "<p>Retrieves a <code>ValueListItem</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/radar/value_list_items/{item}`\n"
    (
      @spec retrieve(
              item :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Radar.ValueListItem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(item, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/radar/value_list_items/{item}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "item",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "item",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [item]
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

    @doc "<p>Creates a new <code>ValueListItem</code> object, which is added to the specified parent value list.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/radar/value_list_items`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:value) => binary,
                optional(:value_list) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Radar.ValueListItem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/radar/value_list_items", [], [])

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

    @doc "<p>Deletes a <code>ValueListItem</code> object, removing it from its parent value list.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/radar/value_list_items/{item}`\n"
    (
      @spec delete(item :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedRadar.ValueListItem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(item, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/radar/value_list_items/{item}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "item",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "item",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [item]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end
