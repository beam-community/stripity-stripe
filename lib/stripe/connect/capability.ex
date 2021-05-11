defmodule Stripe.Capability do
  @moduledoc """
  Work with [Stripe Connect `capability` objects](https://stripe.com/docs/api/capabilities).

  You can:
  - [Retrieve an Account Capability](https://stripe.com/docs/api/capabilities/retrieve)
  - [Update an Account Capability](https://stripe.com/docs/api/capabilities/update)
  - [List all account capabilities](https://stripe.com/docs/api/capabilities/list)
  """

  use Stripe.Entity
  import Stripe.Request

  @spec accounts_plural_endpoint(params) :: String.t() when params: %{:account => Stripe.id()}
  defp accounts_plural_endpoint(%{account: id}) do
    "accounts/#{id}/capabilities"
  end

  @type requirements :: %{
          current_deadline: Stripe.timestamp() | nil,
          currently_due: Stripe.List.t(String.t()) | nil,
          disabled_reason: String.t() | nil,
          eventually_due: Stripe.List.t(String.t()) | nil,
          past_due: Stripe.List.t(String.t()) | nil,
          pending_verification: Stripe.List.t(String.t()) | nil
        }

  @type t :: %__MODULE__{
          account: Stripe.Account.t(),
          id: String.t(),
          object: String.t(),
          requested_at: Stripe.timestamp(),
          requested: boolean | nil,
          requirements: requirements | nil,
          status: String.t() | nil
        }

  defstruct [
    :account,
    :id,
    :object,
    :requested_at,
    :requested,
    :requirements,
    :status
  ]

  @doc """
  Retrieves information about the specified Account Capability.
  """
  @spec retrieve(Stripe.id(), params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{:account => Stripe.id()}
  def retrieve(id, %{account: _} = params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Updates an existing Account Capability.
  """
  @spec update(Stripe.id(), params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :account => Stripe.id(),
               optional(:requested) => boolean
             }
  def update(id, %{account: _} = params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params |> Map.delete(:account))
    |> make_request()
  end

  @doc """
  Returns a list of capabilities associated with the account
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{:account => Stripe.id()}
  def list(params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_method(:get)
    |> make_request()
  end
end
