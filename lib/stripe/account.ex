defmodule Stripe.Account do
  @moduledoc """
  Work with Stripe account objects.

  You can:

  - Retrieve your own account
  - Retrieve an account with a specified `id`

  This module does not yet support managed accounts.

  Stripe API reference: https://stripe.com/docs/api#account
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :business_name, :business_primary_color, :business_url,
    :charges_enabled, :country, :default_currency, :details_submitted,
    :display_name, :email, :managed, :metadata, :statement_descriptor,
    :support_email, :support_phone, :support_url, :timezone,
    :transfers_enabled
  ]

  @singular_endpoint "account"
  @plural_endpoint "accounts"

  @doc """
  Retrieve your own account without options.
  """
  @spec retrieve :: {:ok, t} | {:error, Exception.t}
  def retrieve, do: retrieve([])

  @doc """
  Retrieve your own account with options.
  """
  @spec retrieve(Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def retrieve(opts), do: do_retrieve(@singular_endpoint, opts)

  @doc """
  Retrieve an account with a specified `id`.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def retrieve(id, opts \\ []), do: do_retrieve(@plural_endpoint <> "/" <> id, opts)

  @spec do_retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  defp do_retrieve(endpoint, opts) do
    case Stripe.request(:get, endpoint, %{}, %{}, opts) do
      {:ok, result} -> {:ok, to_struct(result)}
      {:error, error} -> {:error, error}
    end
  end

  defp to_struct(response) do
    %__MODULE__{
      id: Map.get(response, "id"),
      business_name: Map.get(response, "business_name"),
      business_primary_color: Map.get(response, "business_primary_color"),
      business_url: Map.get(response, "business_url"),
      charges_enabled: Map.get(response, "charges_enabled"),
      country: Map.get(response, "country"),
      default_currency: Map.get(response, "default_currency"),
      details_submitted: Map.get(response, "details_submitted"),
      display_name: Map.get(response, "display_name"),
      email: Map.get(response, "email"),
      managed: Map.get(response, "managed"),
      metadata: Map.get(response, "metadata"),
      statement_descriptor: Map.get(response, "statement_descriptor"),
      support_email: Map.get(response, "support_email"),
      support_phone: Map.get(response, "support_phone"),
      support_url: Map.get(response, "support_url"),
      timezone: Map.get(response, "timezone"),
      transfers_enabled: Map.get(response, "transfers_enabled")
    }
  end
end
