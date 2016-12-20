defmodule Stripe.Request do
  alias Stripe.Util
  alias Stripe.Converter

  @spec create(String.t, struct, map, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def create(endpoint, struct, valid_keys, module, opts) do
    body =
      struct
      |> Map.take(valid_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, body, %{}, opts) do
      {:ok, result} -> {:ok, Converter.stripe_map_to_struct(module, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec create_file_upload(String.t, Path.t, String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def create_file_upload(endpoint, filepath, purpose, module, opts) do
    body = {:multipart, [{"purpose", purpose}, {:file, filepath}]}
    case Stripe.request_file_upload(:post, endpoint, body, %{}, opts) do
      {:ok, result} -> {:ok, Converter.stripe_map_to_struct(module, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec retrieve(String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve(endpoint, module, opts) do
    case Stripe.request(:get, endpoint, %{}, %{}, opts) do
      {:ok, result} -> {:ok, Converter.stripe_map_to_struct(module, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec retrieve_file_upload(String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_file_upload(endpoint, module, opts) do
    case Stripe.request_file_upload(:get, endpoint, %{}, %{}, opts) do
      {:ok, result} -> {:ok, Converter.stripe_map_to_struct(module, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec update(String.t, map, map, struct, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def update(endpoint, changes, valid_keys, module, opts) do
    body =
      changes
      |> Util.map_keys_to_atoms()
      |> Map.take(valid_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, body, %{}, opts) do
      {:ok, result} -> {:ok, Converter.stripe_map_to_struct(module, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete(String.t, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(endpoint, opts) do
    case Stripe.request(:delete, endpoint, %{}, %{}, opts) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end
end
