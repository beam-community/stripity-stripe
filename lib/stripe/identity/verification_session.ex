defmodule Stripe.Identity.VerificationSession do
  @moduledoc """
  Work with Stripe Identity VerificationSession objects.

  You can:
    - Create a Verification Session
    - **A lot of other things soon!!**

  Stripe API reference: https://stripe.com/docs/api/identity/verification_sessions
  """

  use Stripe.Entity
  import Stripe.Request

  @type last_error :: %{
          code: list(String.t()),
          reason: String.t()
        }

  @type options :: %{
          document: %{
            allowed_types: list(String.t()),
            require_id_number: boolean,
            require_live_capture: boolean,
            require_matching_selfie: boolean
          },
          id_number: map
        }

  @type redaction :: %{
          status: String.t()
        }

  @type verified_outputs :: %{
          address: %{
            city: String.t(),
            country: String.t(),
            line1: String.t(),
            line2: String.t(),
            postal_code: String.t(),
            state: String.t()
          },
          dob: %{
            day: integer,
            month: integer,
            year: integer
          },
          first_name: String.t(),
          id_number: String.t(),
          id_number_type: String.t(),
          last_name: String.t()
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          client_secret: String.t() | nil,
          created: Stripe.timestamp(),
          last_error: last_error | nil,
          last_verification_report: String.t(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          options: options,
          redaction: redaction | nil,
          status: String.t(),
          type: String.t(),
          url: String.t() | nil,
          verified_outputs: verified_outputs | nil
        }

  defstruct [
    :id,
    :object,
    :client_secret,
    :created,
    :last_error,
    :last_verification_report,
    :livemode,
    :metadata,
    :options,
    :redaction,
    :status,
    :type,
    :url,
    :verified_outputs
  ]

  @plural_endpoint "identity/verification_sessions"

  @doc """
  Create a VerificationSession
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :type => String.t(),
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:options) => options,
               optional(:return_url) => String.t()
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end
end
