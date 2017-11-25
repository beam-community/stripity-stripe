defmodule Stripe.Source do
  @moduledoc """
  Work with Stripe source objects.

  Stripe API reference: https://stripe.com/docs/api#sources
  """

  use Stripe.Entity
  import Stripe.Request

  @type source_type :: String.t()

  @type ach_credit_transfer :: %{
          account_number: String.t() | nil,
          bank_name: String.t() | nil,
          fingerprint: String.t() | nil,
          routing_number: String.t() | nil,
          swift_code: String.t() | nil
        }

  @type alipay :: %{
          data_string: String.t() | nil,
          native_url: String.t() | nil,
          statement_descriptor: String.t() | nil
        }

  @type bancontact :: %{
          bank_code: String.t() | nil,
          bank_name: String.t() | nil,
          bic: String.t() | nil,
          preferred_language: String.t() | nil,
          statement_descriptor: String.t() | nil
        }

  @type bitcoin :: %{
          address: String.t() | nil,
          amount: String.t() | nil,
          amount_charged: String.t() | nil,
          amount_received: String.t() | nil,
          amount_returned: String.t() | nil,
          refund_address: String.t() | nil,
          uri: String.t() | nil
        }

  @type card :: %{
          address_line1_check: String.t() | nil,
          address_zip_check: String.t() | nil,
          brand: String.t() | nil,
          country: String.t() | nil,
          cvc_check: String.t() | nil,
          dynamic_last4: String.t() | nil,
          exp_month: integer | nil,
          exp_year: integer | nil,
          fingerprint: String.t(),
          funding: String.t() | nil,
          last4: String.t() | nil,
          skip_validation: boolean,
          three_d_secure: String.t(),
          tokenization_method: String.t() | nil
        }

  @type code_verification_flow :: %{
          attempts_remaining: integer,
          status: String.t()
        }

  @type giropay :: %{
          bank_code: String.t() | nil,
          bank_name: String.t() | nil,
          bic: String.t() | nil,
          statement_descriptor: String.t() | nil
        }

  @type ideal :: %{
          bank: String.t() | nil,
          bic: String.t() | nil,
          iban_last4: String.t() | nil,
          statement_descriptor: String.t() | nil
        }

  @type owner :: %{
          address: Stripe.Types.address() | nil,
          email: String.t() | nil,
          name: String.t() | nil,
          phone: String.t() | nil,
          verifired_address: Stripe.Types.address() | nil,
          verified_email: String.t() | nil,
          verified_name: String.t() | nil,
          verified_phone: String.t() | nil
        }

  @type p24 :: %{
          reference: String.t() | nil
        }

  @type receiver_flow :: %{
          address: String.t() | nil,
          amount_charged: integer,
          amount_received: integer,
          amount_returned: integer
        }

  @type redirect_flow :: %{
          failure_reason: String.t() | nil,
          return_url: String.t(),
          status: String.t(),
          url: String.t()
        }

  @type sofort :: %{
          bank_code: String.t() | nil,
          bank_name: String.t() | nil,
          bic: String.t() | nil,
          country: String.t() | nil,
          iban_last4: String.t() | nil,
          preferred_language: String.t() | nil,
          statement_descriptor: String.t() | nil
        }

  @type three_d_secure :: %{
          authenticated: boolean | nil,
          card: String.t() | nil,
          customer: String.t() | nil
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          ach_credit_transfer: ach_credit_transfer | nil,
          alipay: alipay | nil,
          amount: integer | nil,
          bancontact: bancontact | nil,
          bitcoin: bitcoin | nil,
          card: card | nil,
          client_secret: String.t(),
          code_verification: code_verification_flow | nil,
          created: Stripe.timestamp(),
          currency: String.t() | nil,
          flow: String.t(),
          giropay: giropay | nil,
          ideal: ideal | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          owner: owner | nil,
          p24: p24 | nil,
          receiver: receiver_flow | nil,
          redirect: redirect_flow | nil,
          sofort: sofort | nil,
          statement_descriptor: String.t() | nil,
          status: String.t(),
          three_d_secure: three_d_secure | nil,
          type: source_type,
          usage: String.t() | nil
        }

  defstruct [
    :id,
    :object,
    :ach_credit_transfer,
    :alipay,
    :amount,
    :bancontact,
    :bitcoin,
    :card,
    :client_secret,
    :code_verification,
    :created,
    :currency,
    :flow,
    :giropay,
    :ideal,
    :livemode,
    :metadata,
    :owner,
    :p24,
    :receiver,
    :redirect,
    :sofort,
    :statement_descriptor,
    :status,
    :three_d_secure,
    :type,
    :usage
  ]

  @plural_endpoint "sources"

  @doc """
  Create a source.
  """
  @spec create(map, Keyword.t()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def create(%{} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a source.
  """
  @spec retrieve(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, %{} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Update a source.

  Takes the `id` and a map of changes
  """
  @spec update(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def update(id, %{} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  defp customer_endpoint(%{customer: id}) do
    "customers/" <> id <> "/sources"
  end

  @doc """
  Attach a source to a customer.
  """
  @spec attach(map, Keyword.t()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def attach(%{customer: _, source: _} = params, opts \\ []) do
    endpoint = params |> customer_endpoint()

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_params(params |> Map.delete(:customer))
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Detach a source from a customer.
  """
  @spec detach(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def detach(id, %{customer: _} = params, opts \\ []) do
    endpoint = params |> customer_endpoint()

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end
end
