defmodule Stripe.Terminal.Location do
  use Stripe.Entity

  @moduledoc "A Location represents a grouping of readers.\n\nRelated guide: [Fleet management](https://stripe.com/docs/terminal/fleet/locations)"
  (
    defstruct [
      :address,
      :configuration_overrides,
      :display_name,
      :id,
      :livemode,
      :metadata,
      :object
    ]

    @typedoc "The `terminal.location` type.\n\n  * `address` \n  * `configuration_overrides` The ID of a configuration that will be used to customize all readers in this location.\n  * `display_name` The display name of the location.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            address: term,
            configuration_overrides: binary,
            display_name: binary,
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary
          }
  )

  (
    @typedoc "The full address of the location."
    @type address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    nil

    @doc "<p>Retrieves a <code>Location</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/terminal/locations/{location}`\n"
    (
      @spec retrieve(
              location :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Location.t() | Stripe.DeletedTerminal.Location.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(location, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/locations/{location}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "location",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "location",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [location]
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

    @doc "<p>Creates a new <code>Location</code> object.\nFor further details, including which address fields are required in each country, see the <a href=\"/docs/terminal/fleet/locations\">Manage locations</a> guide.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/locations`\n"
    (
      @spec create(
              params :: %{
                optional(:address) => address,
                optional(:configuration_overrides) => binary,
                optional(:display_name) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Location.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/locations", [], [])

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

    @doc "<p>Updates a <code>Location</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/locations/{location}`\n"
    (
      @spec update(
              location :: binary(),
              params :: %{
                optional(:address) => address,
                optional(:configuration_overrides) => binary,
                optional(:display_name) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Location.t() | Stripe.DeletedTerminal.Location.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(location, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/locations/{location}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "location",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "location",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [location]
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

    @doc "<p>Returns a list of <code>Location</code> objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/terminal/locations`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Terminal.Location.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/locations", [], [])

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

    @doc "<p>Deletes a <code>Location</code> object.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/terminal/locations/{location}`\n"
    (
      @spec delete(location :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedTerminal.Location.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(location, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/locations/{location}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "location",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "location",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [location]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end
