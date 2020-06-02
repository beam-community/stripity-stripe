defmodule Stripe.Terminal.ConnectionToken do
  @moduledoc """
  A Connection Token is used by the Stripe Terminal SDK to connect to a reader.

  You can:
  - [Create a connection token](https://stripe.com/docs/api/terminal/connection_tokens/create)
  """

  use Stripe.Entity
  import Stripe.Request
  require Stripe.Util

  @type t :: %__MODULE__{
          id: Stripe.id(),
          location: String.t(),
          secret: String.t(),
          object: String.t()
        }

  defstruct [
    :id,
    :location,
    :secret,
    :object
  ]

  @plural_endpoint "terminal/connection_tokens"

  @doc """
  Create a new Connection Token

  To connect to a reader the Stripe Terminal SDK needs to retrieve a short-lived
  connection token from Stripe, proxied through your server. On your backend,
  add an endpoint that creates and returns a connection token.
  """

  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:location) => String.t()
               }
               | %{}

  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end
end
