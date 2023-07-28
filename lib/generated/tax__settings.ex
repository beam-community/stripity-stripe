defmodule Stripe.Tax.Settings do
  use Stripe.Entity

  @moduledoc "You can use Tax `Settings` to manage configurations used by Stripe Tax calculations.\n\nRelated guide: [Using the Settings API](https://stripe.com/docs/tax/settings-api)"
  (
    defstruct [:defaults, :head_office, :livemode, :object, :status, :status_details]

    @typedoc "The `tax.settings` type.\n\n  * `defaults` \n  * `head_office` The place where your business is located.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` The `active` status indicates you have all required settings to calculate tax. A status can transition out of `active` when new required settings are introduced.\n  * `status_details` \n"
    @type t :: %__MODULE__{
            defaults: term,
            head_office: term | nil,
            livemode: boolean,
            object: binary,
            status: binary,
            status_details: term
          }
  )

  (
    @typedoc "The location of the business for tax purposes."
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
    @typedoc "Default configuration to be used on Stripe Tax calculations."
    @type defaults :: %{
            optional(:tax_behavior) => :exclusive | :inclusive | :inferred_by_currency,
            optional(:tax_code) => binary
          }
  )

  (
    @typedoc "The place where your business is located."
    @type head_office :: %{optional(:address) => address}
  )

  (
    nil

    @doc "<p>Retrieves Tax <code>Settings</code> for a merchant.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/tax/settings`\n"
    (
      @spec retrieve(params :: %{optional(:expand) => list(binary)}, opts :: Keyword.t()) ::
              {:ok, Stripe.Tax.Settings.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax/settings", [], [])

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

    @doc "<p>Updates Tax <code>Settings</code> parameters used in tax calculations. All parameters are editable but none can be removed once set.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/tax/settings`\n"
    (
      @spec update(
              params :: %{
                optional(:defaults) => defaults,
                optional(:expand) => list(binary),
                optional(:head_office) => head_office
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Tax.Settings.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/tax/settings", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end