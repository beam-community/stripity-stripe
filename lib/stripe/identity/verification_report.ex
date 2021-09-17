defmodule Stripe.Identity.VerificationReport do
  @moduledoc """
  Work with Stripe Identity VerificationReport objects.

  You can:
    - Retrieve a Verification Report with a specified `id`.
    - List all Verification Reports.

  Stripe API reference: https://stripe.com/docs/api/identity/verification_reports
  """

  use Stripe.Entity
  import Stripe.Request

  alias Stripe.Identity.VerificationSession

  @type options :: %{
          document: %{
            allowed_types: list(String.t()),
            require_id_number: boolean(),
            require_live_capture: boolean(),
            require_matching_selfie: boolean()
          },
          id_number: map()
        }

  @type document :: %{
          address: %{
            city: String.t(),
            country: String.t(),
            line1: String.t(),
            line2: String.t(),
            postal_code: String.t(),
            state: String.t()
          },
          dob: %{
            day: integer(),
            month: integer(),
            year: integer()
          },
          error: %{
            code: String.t(),
            reason: String.t()
          },
          expiration_date: %{
            day: integer(),
            month: integer(),
            year: integer()
          },
          files: [Stripe.id()],
          first_name: String.t(),
          issued_date: String.t(),
          issuing_country: String.t(),
          last_name: String.t(),
          number: String.t(),
          status: String.t(),
          type: String.t()
        }

  @type id_number :: %{
          dob: %{
            day: integer(),
            month: integer(),
            year: integer()
          },
          error: %{
            code: String.t(),
            reason: String.t()
          },
          first_name: String.t(),
          id_number: String.t(),
          id_number_type: String.t(),
          last_name: String.t(),
          status: String.t()
        }

  @type selfie :: %{
          document: String.t(),
          error: %{
            code: String.t(),
            reason: String.t()
          },
          selfie: String.t(),
          status: String.t()
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          created: Stripe.timestamp(),
          livemode: boolean(),
          options: options(),
          type: String.t(),
          verification_session: Stripe.id(),
          document: document(),
          id_number: id_number(),
          selfie: selfie()
        }

  defstruct [
    :id,
    :object,
    :created,
    :livemode,
    :options,
    :type,
    :verification_session,
    :document,
    :id_number,
    :selfie
  ]

  @plural_endpoint "identity/verification_reports"

  @doc """
  Retrieves an existing VerificationReport.
  """
  @spec retrieve(Stripe.id() | t(), Stripe.options()) :: {:ok, t()} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  List all Verification Reports.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t())} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:created) => Stripe.date_query(),
               optional(:type) => String.t(),
               optional(:verification_session) => VerificationSession.t() | Stripe.id(),
               optional(:ending_before) => t() | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t() | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:verification_session, :ending_before, :starting_after])
    |> make_request()
  end
end
