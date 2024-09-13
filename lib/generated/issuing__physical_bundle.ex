defmodule Stripe.Issuing.PhysicalBundle do
  use Stripe.Entity

  @moduledoc "A Physical Bundle represents the bundle of physical items - card stock, carrier letter, and envelope - that is shipped to a cardholder when you create a physical card."
  (
    defstruct [:features, :id, :livemode, :name, :object, :status, :type]

    @typedoc "The `issuing.physical_bundle` type.\n\n  * `features` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `name` Friendly display name.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` Whether this physical bundle can be used to create cards.\n  * `type` Whether this physical bundle is a standard Stripe offering or custom-made for you.\n"
    @type t :: %__MODULE__{
            features: term,
            id: binary,
            livemode: boolean,
            name: binary,
            object: binary,
            status: binary,
            type: binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of physical bundle objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/physical_bundles`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :active | :inactive | :review,
                optional(:type) => :custom | :standard
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.PhysicalBundle.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/physical_bundles", [], [])

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

    @doc "<p>Retrieves a physical bundle object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/physical_bundles/{physical_bundle}`\n"
    (
      @spec retrieve(
              physical_bundle :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.PhysicalBundle.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(physical_bundle, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/physical_bundles/{physical_bundle}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "physical_bundle",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "physical_bundle",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [physical_bundle]
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