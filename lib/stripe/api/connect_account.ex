defmodule Stripe.API.ConnectAccount do
  @moduledoc false

  @doc """
  Makes the request on behalf of a connected account.

  Adds a request step setting the `stripe-account` header when an account is given, leaving the
  request untouched otherwise.

  ## Request Options

    * `:connect_account` - the ID of the account to act for, as in `"acct_134151"`.
  """
  @spec attach(Req.Request.t()) :: Req.Request.t()
  def attach(%Req.Request{} = request) do
    request
    |> Req.Request.register_options([:connect_account])
    |> Req.Request.append_request_steps(stripe_connect_account: &put_connect_header/1)
  end

  defp put_connect_header(request) do
    if account_id = Req.Request.get_option(request, :connect_account) do
      Req.Request.put_header(request, "stripe-account", account_id)
    else
      request
    end
  end
end
