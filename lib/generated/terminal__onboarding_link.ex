# credo:disable-for-this-file
defmodule Stripe.Terminal.OnboardingLink do
  use Stripe.Entity
  @moduledoc "Returns redirect links used for onboarding onto Tap to Pay on iPhone."
  (
    defstruct [:link_options, :link_type, :object, :on_behalf_of, :redirect_url]

    @typedoc "The `terminal.onboarding_link` type.\n\n  * `link_options` \n  * `link_type` The type of link being generated.\n  * `object` \n  * `on_behalf_of` Stripe account ID to generate the link for.\n  * `redirect_url` The link passed back to the user for their onboarding.\n"
    @type t :: %__MODULE__{
            link_options: term,
            link_type: binary,
            object: binary,
            on_behalf_of: binary | nil,
            redirect_url: binary
          }
  )

  (
    @typedoc "The options associated with the Apple Terms and Conditions link type."
    @type apple_terms_and_conditions :: %{
            optional(:allow_relinking) => boolean,
            optional(:merchant_display_name) => binary
          }
  )

  (
    @typedoc "Specific fields needed to generate the desired link type."
    @type link_options :: %{optional(:apple_terms_and_conditions) => apple_terms_and_conditions}
  )

  (
    nil

    @doc "<p>Creates a new <code>OnboardingLink</code> object that contains a redirect_url used for onboarding onto Tap to Pay on iPhone.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/onboarding_links`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:link_options) => link_options,
                optional(:link_type) => :apple_terms_and_conditions,
                optional(:on_behalf_of) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.OnboardingLink.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/onboarding_links", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
