defmodule Stripe.Request do
  alias Stripe.Changeset
  alias Stripe.Converter

  @spec create(String.t, map, map, module, Keyword.t) :: {:ok, map} | {:error, Stripe.api_error_struct}
  def create(endpoint, changes, schema, module, opts) do
    body =
      changes
      |> Changeset.cast(schema, :create)

    Stripe.request(:post, endpoint, body, %{}, opts)
    |> handle_result(module)
  end

  @spec create_file_upload(String.t, Path.t, String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def create_file_upload(endpoint, filepath, purpose, module, opts) do
    body = {:multipart, [{"purpose", purpose}, {:file, filepath}]}
    Stripe.request_file_upload(:post, endpoint, body, %{}, opts)
    |> handle_result(module)
  end

  @spec retrieve(String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve(endpoint, module, opts) do
    Stripe.request(:get, endpoint, %{}, %{}, opts)
    |> handle_result(module)
  end

  @spec retrieve_many(String.t, module, Keyword.t) :: {:ok, boolean, [struct]} | {:error, Stripe.api_error_struct}
  def retrieve_many(endpoint, module, opts) do
    case Stripe.request(:get, endpoint, %{}, %{}, opts) do
      {:error, error} -> {:error, error}
      {:ok, %{"data" => data, "has_more" => has_more}} ->
        results = Enum.map(data, &Converter.stripe_map_to_struct(module, &1))
        {:ok, has_more, results}
    end
  end

  @spec retrieve_file_upload(String.t, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def retrieve_file_upload(endpoint, module, opts) do
    Stripe.request_file_upload(:get, endpoint, %{}, %{}, opts)
    |> handle_result(module)
  end

  @spec update(String.t, map, map, list, module, Keyword.t) :: {:ok, struct} | {:error, Stripe.api_error_struct}
  def update(endpoint, changes, schema, nullable_keys, module, opts) do
    body =
      changes
      |> Changeset.cast(schema, :update, nullable_keys)

    Stripe.request(:post, endpoint, body, %{}, opts)
    |> handle_result(module)
  end

  @spec delete(String.t, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(endpoint, opts) do
    Stripe.request(:delete, endpoint, %{}, %{}, opts)
    |> handle_result
  end

  @spec retrieve_all(function) :: {:ok, [t]} | {:error, Stripe.api_error_struct}
  def retrieve_all(retrieve_many, opts \\ []) do
    try do
      all =
        retrieve_many
        |> Stripe.Request.stream(opts)
        |> Enum.to_list
      {:ok, all}
    rescue
      error -> {:error, error}
    end
  end

  @spec stream(function, Keyword.t) :: Enumerable.t | no_return
  def stream(retrieve_many, opts) do
    initial_opts = Keyword.take(opts, [:starting_after, :ending_before])
    ongoing_opts = Keyword.take(opts, [:ending_before])

    Stream.resource(
      fn -> nil end,
      fn
        false -> {:halt, :ok}
        starting_after ->
          opts_list =
            if is_nil(starting_after) do
              initial_opts
            else
              Keyword.put(ongoing_opts, :starting_after, starting_after)
            end

          case retrieve_many.(opts_list) do
            # Unfortunately we have to raise here to break out of Stream.
            # But this can easily be rescued and error tuple-ized.
            {:error, error} -> raise error
            {:ok, false, results} -> {results, false}
            {:ok, true, results} ->
              last_result_id =
                results
                |> List.last
                |> Map.fetch!(:id)
              {results, last_result_id}
          end
      end,
      fn _ -> :ok
    end)
  end

  defp handle_result(result, module \\ nil)
  defp handle_result({:ok, _}, nil), do: :ok
  defp handle_result({:ok, result = %{}}, module), do: {:ok, Converter.stripe_map_to_struct(module, result)}
  defp handle_result({:error, error}, _), do: {:error, error}
end
