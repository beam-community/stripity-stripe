defmodule Stripe.Request do
  alias Stripe.Util

  @type stripe_response :: {:ok, t} | {:error, Exception.t}
  @type stripe_delete_response :: :ok | {:error, Exception.t}

  @spec create(String.t, struct, map, struct, Keyword.t) :: stripe_response
  def create(endpoint, struct, valid_keys, return_struct, opts) do
    body =
      struct
      |> Map.take(@valid_create_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, body, %{}, opts) do
      {:ok, result} -> {:ok, Util.stripe_response_to_struct(return_struct, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec retrieve(String.t, struct, Keyword.t) :: stripe_response
  def retrieve(endpoint, return_struct, opts) do
    case Stripe.request(:get, endpoint, %{}, %{}, opts) do
      {:ok, result} -> {:ok, Util.stripe_response_to_struct(return_struct, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec update(String.t, map, map, struct, Keyword.t) :: stripe_response
  def update(endpoint, changes, valid_keys, return_struct, opts) do
    body =
      changes
      |> Util.map_keys_to_atoms()
      |> Map.take(keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, body, %{}, opts) do
      {:ok, result} -> {:ok, Util.stripe_response_to_struct(return_struct, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete(String.t, Keyword.t) :: stripe_delete_response
  def delete(endpoint, opts) do
    case Stripe.request(:delete, endpoint, %{}, %{}, opts) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end
end
