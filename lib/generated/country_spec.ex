defmodule Stripe.CountrySpec do
  use Stripe.Entity

  @moduledoc "Stripe needs to collect certain pieces of information about each account\ncreated. These requirements can differ depending on the account's country. The\nCountry Specs API makes these rules available to your integration.\n\nYou can also view the information from this API call as [an online\nguide](/docs/connect/required-verification-information)."
  (
    defstruct [
      :default_currency,
      :id,
      :object,
      :supported_bank_account_currencies,
      :supported_payment_currencies,
      :supported_payment_methods,
      :supported_transfer_countries,
      :verification_fields
    ]

    @typedoc "The `country_spec` type.\n\n  * `default_currency` The default currency for this country. This applies to both payment methods and bank accounts.\n  * `id` Unique identifier for the object. Represented as the ISO country code for this country.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `supported_bank_account_currencies` Currencies that can be accepted in the specific country (for transfers).\n  * `supported_payment_currencies` Currencies that can be accepted in the specified country (for payments).\n  * `supported_payment_methods` Payment methods available in the specified country. You may need to enable some payment methods (e.g., [ACH](https://stripe.com/docs/ach)) on your account before they appear in this list. The `stripe` payment method refers to [charging through your platform](https://stripe.com/docs/connect/destination-charges).\n  * `supported_transfer_countries` Countries that can accept transfers from the specified country.\n  * `verification_fields` \n"
    @type t :: %__MODULE__{
            default_currency: binary,
            id: binary,
            object: binary,
            supported_bank_account_currencies: term,
            supported_payment_currencies: term,
            supported_payment_methods: term,
            supported_transfer_countries: term,
            verification_fields: term
          }
  )

  (
    nil

    @doc "<p>Lists all Country Spec objects available in the API.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/country_specs`\n"
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
              {:ok, Stripe.List.t(Stripe.CountrySpec.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/country_specs", [], [])

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

    @doc "<p>Returns a Country Spec for a given Country code.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/country_specs/{country}`\n"
    (
      @spec retrieve(
              country :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.CountrySpec.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(country, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/country_specs/{country}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "country",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "country",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [country]
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
