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
    cast_to_id: MapSet.t(atom)
  }

  @type error_code ::  :endpoint_fun_invalid_result
    | :invalid_endpoint

  defstruct opts: [], endpoint: nil, method: nil, params: %{}, cast_to_id: MapSet.new

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

  @spec put_param(t, atom, any) :: t
  def put_param(%Request{params: params} = request, key, value) do
    %{request | params: Map.put(params, key, value)}
  end

  @spec cast_to_id(t, [atom]) :: t
  def cast_to_id(%Request{cast_to_id: cast_to_id} = request, new_cast_to_id) do
    %{request | cast_to_id: MapSet.union(cast_to_id, MapSet.new(new_cast_to_id))}
  end

  @spec cast_path_to_id(t, [atom]) :: t
  def cast_path_to_id(%Request{cast_to_id: cast_to_id} = request, new_cast_to_id) do
    %{request | cast_to_id: MapSet.put(cast_to_id, new_cast_to_id)}
  end

  @spec get_id!(Stripe.id | struct) :: Stripe.id
  def get_id!(id) when is_binary(id), do: id

  def get_id!(%{id: id}) when is_binary(id), do: id

  def get_id!(_), do: raise "You must provide an ID or a struct with an ID to this operation."

  @spec make_request(t) :: {:ok, struct} | {:error, Stripe.Error.t}
  def make_request(%Request{params: params, endpoint: endpoint, method: method, opts: opts} = request) do
    with\
      {:ok, params} <- do_cast_to_id(params, request.cast_to_id),
      {:ok, endpoint} <- consolidate_endpoint(endpoint, params),
      {:ok, result} <- API.request(params, method, endpoint, %{}, opts)
    do
      {:ok, Converter.convert_result(result)}
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
