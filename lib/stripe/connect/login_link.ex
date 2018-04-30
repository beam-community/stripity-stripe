defmodule Stripe.LoginLink do
  @moduledoc """

  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          object: String.t(),
          created: Stripe.timestamp(),
          url: String.t()
        }

  defstruct [
    :object,
    :created,
    :url
  ]

  @spec create(Stripe.id() | Stripe.Account.t(), map, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def create(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint("accounts/#{get_id!(id)}/login_links")
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end
end
