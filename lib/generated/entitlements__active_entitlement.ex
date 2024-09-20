defmodule Stripe.Entitlements.ActiveEntitlement do
  use Stripe.Entity
  @moduledoc "An active entitlement describes access to a feature for a customer."
  (
    defstruct [:feature, :id, :livemode, :lookup_key, :object]

    @typedoc "The `entitlements.active_entitlement` type.\n\n  * `feature` The [Feature](https://stripe.com/docs/api/entitlements/feature) that the customer is entitled to.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `lookup_key` A unique key you provide as your own system identifier. This may be up to 80 characters.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            feature: binary | Stripe.Entitlements.Feature.t(),
            id: binary,
            livemode: boolean,
            lookup_key: binary,
            object: binary
          }
  )

  (
    nil

    @doc "<p>Retrieve a list of active entitlements for a customer</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/entitlements/active_entitlements`\n"
    (
      @spec list(
              params :: %{
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Entitlements.ActiveEntitlement.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/entitlements/active_entitlements", [], [])

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

    @doc "<p>Retrieve an active entitlement</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/entitlements/active_entitlements/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Entitlements.ActiveEntitlement.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/entitlements/active_entitlements/{id}",
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
