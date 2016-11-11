defmodule Stripe.Customer do
  @moduledoc """
  Work with Stripe customer objects.

  You can:

  - Create a customer
  - Retrieve a customer
  - Update a customer
  - Delete a customer

  Stripe API reference: https://stripe.com/docs/api#customer
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :account_balance, :business_vat_id, :created, :currency,
    :default_source, :delinquent, :description, :discount, :email, :livemode,
    :metadata, :shipping, :sources, :subscriptions
  ]

  @plural_endpoint "customers"

  @valid_create_keys [
    :account_balance, :business_vat_id, :coupon, :description, :email,
    :metadata, :plan, :quantity, :shipping, :source, :tax_percent, :trial_end
  ]

  @valid_update_keys [
    :account_balance, :business_vat_id, :coupon, :default_source, :description,
    :email, :metadata, :shipping, :source
  ]

  @doc """
  Create a customer.
  """
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def create(customer, opts \\ []) do
    endpoint = @plural_endpoint

    customer =
      Map.from_struct(customer)
      |> Map.take(@valid_create_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, customer, %{}, opts) do
      {:ok, result} -> {:ok, to_struct(result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Retrieve a customer.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    case Stripe.request(:get, endpoint, %{}, %{}, opts) do
      {:ok, result} -> {:ok, to_struct(result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Update a customer.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Exception.t}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id

    customer =
      changes
      |> Util.map_keys_to_atoms()
      |> Map.take(@valid_update_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, customer, %{}, opts) do
      {:ok, result} -> {:ok, to_struct(result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Delete a customer.
  """
  @spec delete(binary, list) :: :ok | {:error, Exception.t}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id

    case Stripe.request(:delete, endpoint, %{}, %{}, opts) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  defp to_struct(response) do
    %__MODULE__{
      id: Map.get(response, "id"),
      account_balance: Map.get(response, "account_balance"),
      business_vat_id: Map.get(response, "business_vat_id"),
      created: Util.get_date(response, "created"),
      currency: Map.get(response, "currency"),
      default_source: Map.get(response, "default_source"),
      delinquent: Map.get(response, "delinquent"),
      description: Map.get(response, "description"),
      discount: Map.get(response, "discount"),
      email: Map.get(response, "email"),
      livemode: Map.get(response, "livemode"),
      metadata: Map.get(response, "metadata"),
      shipping: Map.get(response, "shipping"),
      sources: Map.get(response, "sources"),
      subscriptions: Map.get(response, "subscriptions")
    }
  end
end
