defmodule Stripe.PaymentSource do
  use Stripe.Entity
  @moduledoc nil
  (
    defstruct []
    @typedoc "The `payment_source` type.\n\n\n"
    @type t :: %__MODULE__{}
  )

  (
    nil

    @doc "<p>List sources for a specified customer.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/sources`\n"
    (
      @spec list(
              customer :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:object) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PaymentSource.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/sources",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Retrieve a specified source for a given customer.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/sources/{id}`\n"
    (
      @spec retrieve(
              customer :: binary(),
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentSource.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(customer, id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/sources/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
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
            [customer, id]
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

    @doc "<p>When you create a new credit card, you must specify a customer or recipient on which to create it.</p>\n\n<p>If the card’s owner has no default card, then the new card will become the default.\nHowever, if the owner already has a default, then it will not change.\nTo change the default, you should <a href=\"/docs/api#update_customer\">update the customer</a> to have a new <code>default_source</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers/{customer}/sources`\n"
    (
      @spec create(
              customer :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:source) => binary,
                optional(:validate) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentSource.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/sources",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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
