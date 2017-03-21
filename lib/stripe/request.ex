defmodule Stripe.Request do
  alias Stripe.Changeset
  alias Stripe.Converter

  @max_stripe_pagination_limit 100

  @spec create(String.t, map, map, Keyword.t) :: {:ok, map} | {:error, Stripe.api_error_struct}
  def create(endpoint, changes, schema, opts) do
    changes
    |> Changeset.cast(schema, :create)
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

  @doc """
  Returns %Stripe.List{} of items, using pagination parameters

  ## Example
  retrieve_many(%{limit: 10, starting_after: 3}, "country_specs", []) => {:ok, %Stripe.List{}}

  For more information on pagination parameters read Stripe docs:
  https://stripe.com/docs/api#pagination
  """
  @spec retrieve_many(map, String.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_many(%{limit: _} = pagination_params, endpoint, opts \\ []) do
    Stripe.request(pagination_params, :get, endpoint, %{}, opts)
    |> handle_result_list(pagination_params, endpoint)
  end

  @doc """
  Returns %Stripe.List{} of all items

  ## Example
  retrieve_all("country_specs") => {:ok, %Stripe.List{}}
  """
  @spec retrieve_all(String.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_all(endpoint, opts \\ []) do
    aggregate_lists(retrieve_many(%{limit: @max_stripe_pagination_limit}, endpoint, opts), [])
  end

  @doc """
  Returns %Stripe.List{} with next set of items, using previously fetched %Stripe.List{}

  ## Example
  {:ok, l} = retrieve_many(%{limit: 10}, "country_specs")
  l |> retrieve_next => {:ok, %Stripe.List{10..20}}
  """
  @spec retrieve_next(Stripe.List.t, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_next(%Stripe.List{limit: limit, url: url, data: data}, opts \\ []) do
    %{id: starting_after} = List.last(data)
    retrieve_many(%{starting_after: starting_after, limit: limit}, url, opts)
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

  @spec delete(String.t, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(endpoint, opts) do
    %{}
    |> Stripe.request(:delete, endpoint, %{}, opts)
    |> handle_result
  end

  defp aggregate_lists(response, aggr) do
    case response do
      {:error, error} -> {:error, error}
      {:ok, %{has_more: false, data: data} = list} ->
        {:ok, Map.put(list, :data, Enum.concat(aggr, data))}
      {:ok, %{has_more: true, data: data} = list} ->
        aggregate_lists(retrieve_next(list, []), Enum.concat(aggr, data))
    end
  end

  defp handle_result_list(result, pagination_params, endpoint) do
    with {:ok, handled_result} <- handle_result(result) do
      {:ok, Map.merge(handled_result, %{
        limit: pagination_params.limit,
        url: endpoint
      })}
    else
      {:error, error} -> {:error, error}
    end
  end

  defp handle_result({:ok, result = %{}}), do: {:ok, Converter.stripe_map_to_struct(result)}
  defp handle_result({:error, error}), do: {:error, error}
end
