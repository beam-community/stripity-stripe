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

  @doc """
  Returns a list of VerificationSessions
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:created) => Stripe.date_query(),
               optional(:status) => String.t(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end

  @doc """
  Retrieves the details of a VerificationSession that was previously created.

  When the session status is requires_input,
  you can use this method to retrieve a valid
  client_secret or url to allow re-submission.
  """
  @spec retrieve(Stripe.id(), Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Updates a VerificationSession object.
  When the session status is requires_input,
  you can use this method to update the verification check and options.
  """
  @spec update(Stripe.id(), params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:options) => options,
               optional(:type) => String.t()
             }
  def update(id, params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params |> Map.delete(:metadata))
    |> make_request()
  end

  @doc """
  A VerificationSession object can be canceled when it is in requires_input status.
  Once canceled, future submission attempts are disabled. This cannot be undone.
  """
  @spec cancel(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def cancel(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/cancel")
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Redact a VerificationSession to remove all collected information from Stripe.
  This will redact the VerificationSession and all objects related to it,
  including VerificationReports, Events, request logs, etc.
  A VerificationSession object can be redacted when it is in requires_input or verified status.
  Redacting a VerificationSession in requires_action state will automatically cancel it.

  The redaction process may take up to four days.
  When the redaction process is in progress,
  the VerificationSession’s redaction.status field will be set to processing;
  when the process is finished, it will change to redacted and an
  identity.verification_session.redacted event will be emitted.

  Redaction is irreversible. Redacted objects are still accessible in the Stripe API,
  but all the fields that contain personal data will be replaced by the string [redacted] or a similar placeholder.
  The metadata field will also be erased. Redacted objects cannot be updated or used for any purpose.
  """
  @spec redact(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def redact(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/redact")
    |> put_method(:post)
    |> make_request()
  end
end
