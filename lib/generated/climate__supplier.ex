defmodule Stripe.Climate.Supplier do
  use Stripe.Entity
  @moduledoc "A supplier of carbon removal."
  (
    defstruct [:id, :info_url, :livemode, :locations, :name, :object, :removal_pathway]

    @typedoc "The `climate.supplier` type.\n\n  * `id` Unique identifier for the object.\n  * `info_url` Link to a webpage to learn more about the supplier.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `locations` The locations in which this supplier operates.\n  * `name` Name of this carbon removal supplier.\n  * `object` String representing the object’s type. Objects of the same type share the same value.\n  * `removal_pathway` The scientific pathway used for carbon removal.\n"
    @type t :: %__MODULE__{
            id: binary,
            info_url: binary,
            livemode: boolean,
            locations: term,
            name: binary,
            object: binary,
            removal_pathway: binary
          }
  )

  (
    nil

    @doc "<p>Lists all available Climate supplier objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/climate/suppliers`\n"
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
              {:ok, Stripe.List.t(Stripe.Climate.Supplier.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/climate/suppliers", [], [])

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

    @doc "<p>Retrieves a Climate supplier object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/climate/suppliers/{supplier}`\n"
    (
      @spec retrieve(
              supplier :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Climate.Supplier.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(supplier, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/climate/suppliers/{supplier}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "supplier",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "supplier",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [supplier]
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