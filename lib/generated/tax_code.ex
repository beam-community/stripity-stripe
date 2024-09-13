defmodule Stripe.TaxCode do
  use Stripe.Entity

  @moduledoc "[Tax codes](https://stripe.com/docs/tax/tax-categories) classify goods and services for tax purposes."
  (
    defstruct [:description, :id, :name, :object]

    @typedoc "The `tax_code` type.\n\n  * `description` A detailed description of which types of products the tax code represents.\n  * `id` Unique identifier for the object.\n  * `name` A short name for the tax code.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{description: binary, id: binary, name: binary, object: binary}
  )

  (
    nil

    @doc "<p>A list of <a href=\"https://stripe.com/docs/tax/tax-categories\">all tax codes available</a> to add to Products in order to allow specific tax calculations.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax_codes`\n"
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
              {:ok, Stripe.List.t(Stripe.TaxCode.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax_codes", [], [])

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

    @doc "<p>Retrieves the details of an existing tax code. Supply the unique tax code ID and Stripe will return the corresponding tax code information.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax_codes/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.TaxCode.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/tax_codes/{id}",
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