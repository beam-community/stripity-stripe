defmodule Stripe.API.Expand do
  @moduledoc false

  @doc """
  Requests expanded responses for the given attributes.

  Adds the expansions to `:params`, so they reach Stripe as `expand[0]=…` in the query string.
  The step is *prepended*, so it runs before `Stripe.Params` encodes the parameters.

  ## Request Options

    * `:expand` - the attributes to expand, as in `["balance_transaction"]`. See
      https://stripe.com/docs/api/expanding_objects.
  """
  @spec attach(Req.Request.t()) :: Req.Request.t()
  def attach(%Req.Request{} = request) do
    request
    |> Req.Request.register_options([:expand])
    |> Req.Request.prepend_request_steps(stripe_expand: &put_expand_params/1)
  end

  defp put_expand_params(request) do
    case Req.Request.fetch_option(request, :expand) do
      {:ok, expansion} ->
        params = Req.Request.get_option(request, :params, [])
        expand = UriQuery.params(expand: expansion)
        Req.Request.put_option(request, :params, Enum.concat(params, expand))

      :error ->
        request
    end
  end
end
