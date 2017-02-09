defmodule Stripe.Request do
  alias Stripe.Changeset
  alias Stripe.Converter

  @spec create(String.t, map, map, module, Keyword.t) :: {:ok, map} | {:error, Stripe.api_error_struct}
  def create(endpoint, changes, schema, module, opts) do
    changes
    |> Changeset.cast(schema, :create)
    |> Stripe.request(:post, endpoint, %{}, opts)
    |> handle_result(module)
  end

  @spec create_file_upload(String.t, Path.t, String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def create_file_upload(endpoint, filepath, purpose, module, opts) do
    body = {:multipart, [{"purpose", purpose}, {:file, filepath}]}

    body
    |> Stripe.request_file_upload(:post, endpoint, %{}, opts)
    |> handle_result(module)
  end

  @spec retrieve(String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve(endpoint, module, opts) do
    %{}
    |> Stripe.request(:get, endpoint, %{}, opts)
    |> handle_result(module)
  end

  @spec retrieve_file_upload(String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_file_upload(endpoint, module, opts) do
    %{}
    |> Stripe.request_file_upload(:get, endpoint, %{}, opts)
    |> handle_result(module)
  end

  @spec update(String.t, map, map, list, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def update(endpoint, changes, schema, nullable_keys, module, opts) do
    changes
    |> Changeset.cast(schema, :update, nullable_keys)
    |> Stripe.request(:post, endpoint, %{}, opts)
    |> handle_result(module)
  end

  @spec delete(String.t, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(endpoint, opts) do
    %{}
    |> Stripe.request(:delete, endpoint, %{}, opts)
    |> handle_result
  end

  def handle_result(result, module \\ nil)
  def handle_result({:ok, _}, nil), do: :ok
  def handle_result({:ok, result = %{}}, module), do: {:ok, Converter.stripe_map_to_struct(module, result)}
  def handle_result({:error, error}, _), do: {:error, error}
end
