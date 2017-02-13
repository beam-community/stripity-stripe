defmodule Stripe.Request do
  alias Stripe.Converter

  @spec create(String.t, map, Keyword.t) :: {:ok, map} | {:error, Stripe.api_error_struct}
  def create(endpoint, changes, opts) do
    changes
    |> Stripe.request(:post, endpoint, %{}, opts)
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
  def retrieve(endpoint, opts) do
    %{}
    |> Stripe.request(:get, endpoint, %{}, opts)
    |> handle_result
  end

  @spec retrieve_file_upload(String.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_file_upload(endpoint, opts) do
    %{}
    |> Stripe.request_file_upload(:get, endpoint, %{}, opts)
    |> handle_result
  end

  @spec update(String.t, map, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def update(endpoint, changes, opts) do
    changes
    |> Stripe.request(:post, endpoint, %{}, opts)
    |> handle_result
  end

  @spec delete(String.t, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(endpoint, opts) do
    %{}
    |> Stripe.request(:delete, endpoint, %{}, opts)
    |> handle_result
  end

  def handle_result({:ok, result = %{}}), do: {:ok, Converter.stripe_map_to_struct(result)}
  def handle_result({:error, error}), do: {:error, error}
end
