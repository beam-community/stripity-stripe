defmodule Stripe.Request do
  alias Stripe.Changeset
  alias Stripe.Converter

  @spec create(String.t, map, map, Keyword.t, map) :: {:ok, map} | {:error, Stripe.api_error_struct}
  def create(endpoint, changes, schema, opts, headers \\ %{}) do
    changes
    |> Changeset.cast(schema, :create)
    |> Stripe.request(:post, endpoint, headers, opts)
    |> handle_result
  end

  @spec create_file_upload(String.t, Path.t, String.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def create_file_upload(endpoint, filepath, purpose, opts) do
    body = {:multipart, [{"purpose", purpose}, {:file, filepath}]}

    body
    |> Stripe.request_file_upload(:post, endpoint, %{}, opts)
    |> handle_result
  end

  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve(endpoint, opts), do: retrieve(%{}, endpoint, opts)

  @spec retrieve(map, String.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve(changes, endpoint, opts) do
    changes
    |> Stripe.request(:get, endpoint, %{}, opts)
    |> handle_result
  end

  @spec retrieve_file_upload(String.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_file_upload(endpoint, opts) do
    %{}
    |> Stripe.request_file_upload(:get, endpoint, %{}, opts)
    |> handle_result
  end

  @spec update(String.t, map, map, list, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def update(endpoint, changes, schema, nullable_keys, opts) do
    changes
    |> Changeset.cast(schema, :update, nullable_keys)
    |> Stripe.request(:post, endpoint, %{}, opts)
    |> handle_result
  end

  @spec delete(String.t, map, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(endpoint, params, opts) do
    params
    |> Stripe.request(:delete, endpoint, %{}, opts)
    |> handle_result
  end

  defp handle_result({:ok, result = %{}}), do: {:ok, Converter.convert_result(result)}
  defp handle_result({:error, error}), do: {:error, error}
end
