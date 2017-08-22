defmodule Stripe.Request do
  @moduledoc """
  A module for working with requests to the Stripe API.


  """
  alias Stripe.{API, Request, Converter}

  @opaque t :: %__MODULE__{
    opts: Keyword.t,
    endpoint: String.t | (map -> String.t),
    method: Stripe.API.method,
    params: %{optional(atom) => any},
    valid_keys: nil | MapSet.t(atom),
    required_keys: MapSet.t(atom),
    cast_to_id: MapSet.t(atom)
  }

  @type error_code :: :valid_keys_failed | :required_keys_failed | :endpoint_fun_invalid_result
    | :invalid_endpoint

  defstruct opts: [], endpoint: nil, method: nil, params: %{}, valid_keys: nil,
            required_keys: MapSet.new(), cast_to_id: MapSet.new

  @spec new_request(Stripe.options) :: t
  def new_request(opts \\ []) do
    %Request{opts: opts}
  end

  @spec put_endpoint(t, String.t) :: t
  def put_endpoint(%Request{} = request, endpoint) do
    %{request | endpoint: endpoint}
  end

  @spec put_method(t, Stripe.API.method) :: t
  def put_method(%Request{} = request, method) when method in [:get, :post, :put, :patch, :delete] do
    %{request | method: method}
  end

  @spec put_params(t, map) :: t
  def put_params(%Request{params: params} = request, new_params) do
    %{request | params: Map.merge(params, new_params)}
  end

  @spec valid_keys(t, [atom]) :: t
  def valid_keys(%Request{valid_keys: valid_keys} = request, new_valid_keys) do
    valid_keys =
      case valid_keys do
        nil -> MapSet.new
        valid_keys -> valid_keys
      end

    %{request | valid_keys: MapSet.union(valid_keys, MapSet.new(new_valid_keys))}
  end

  @spec cast_to_id(t, [atom]) :: t
  def cast_to_id(%Request{cast_to_id: cast_to_id} = request, new_cast_to_id) do
    %{request | cast_to_id: MapSet.union(cast_to_id, MapSet.new(new_cast_to_id))}
  end

  @spec required_keys(t, [atom]) :: t
  def required_keys(%Request{required_keys: required_keys} = request, new_required_keys) do
    %{request | required_keys: MapSet.union(required_keys, MapSet.new(new_required_keys))}
  end

  @spec make_request(t) :: {:ok, struct} | {:error, Stripe.Error.t}
  def make_request(%Request{params: params, endpoint: endpoint, method: method, opts: opts} = request) do
    with\
      :ok <- check_valid_keys(params, request.valid_keys),
      :ok <- check_required_keys(params, request.required_keys),
      {:ok, params} <- do_cast_to_id(params, request.cast_to_id),
      {:ok, endpoint} <- consolidate_endpoint(endpoint, params),
      {:ok, result} <- API.request(params, method, endpoint, %{}, opts)
    do
      {:ok, Converter.convert_result(result)}
    end
  end

  defp check_valid_keys(_, nil), do: :ok
  defp check_valid_keys(params, valid_keys) do
    invalid_keys =
      params
      |> Map.keys
      |> MapSet.new
      |> MapSet.difference(valid_keys)
      |> MapSet.to_list

    case invalid_keys do
      [] -> :ok
      invalid_keys ->
        {:error, Stripe.Error.new(source: :internal, code: :valid_keys_failed,
          message: "unknown param keys provided: #{inspect invalid_keys}")}
    end
  end

  defp check_required_keys(params, required_keys) do
    keyset =
      params
      |> Map.keys
      |> MapSet.new

    if MapSet.subset?(required_keys, keyset) do
      :ok
    else
      missing_keys = MapSet.difference(required_keys, keyset) |> MapSet.to_list
      {:error, Stripe.Error.new(source: :internal, code: :required_keys_failed,
        message: "required param keys not provided: #{inspect missing_keys}")}
    end
  end

  defp do_cast_to_id(params, cast_to_id) do
    to_cast = MapSet.to_list(cast_to_id)
    params = Enum.reduce(to_cast, params, fn
      key, params ->
        case params[key] do
          %{__struct__: _, id: id} -> put_in(params[key], id)
          _ -> params
        end
    end)
    {:ok, params}
  end

  defp consolidate_endpoint(endpoint, _) when is_binary(endpoint), do: {:ok, endpoint}
  defp consolidate_endpoint(endpoint_fun, params) when is_function(endpoint_fun, 1) do
    case endpoint_fun.(params) do
      result when is_binary(result) -> {:ok, result}
      invalid -> {:error,
                   Stripe.Error.new(source: :internal, code: :endpoint_fun_invalid_result,
                    message: "calling the endpoint function produced an invalid result of #{inspect invalid} ")}
    end
  end
  defp consolidate_endpoint(_, _) do
    {:error, Stripe.Error.new(source: :internal, code: :invalid_endpoint,
      message: "endpoint must be a string or a function from params to a string")}
  end


end
