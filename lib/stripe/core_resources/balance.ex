defmodule Stripe.Balance do
  @moduledoc """
  Work with [Stripe `balance` objects](https://stripe.com/docs/api#balance).

  You can:
  - [Retrieve the current balance](https://stripe.com/docs/api#retrieve_balance)
  """
  use Stripe.Entity
  import Stripe.Request

  @type funds :: %{
    currency: String.t,
    amount: integer,
    source_types: %{
      Stripe.Source.source_type => integer
    }
  }

  @type t :: %__MODULE__{
    object: String.t,
    available: list(funds),
    connect_reserved: list(funds) | nil,
    livemode: boolean,
    pending: list(funds)
  }

  defstruct [
    :object,
    :available,
    :connect_reserved,
    :livemode,
    :pending
  ]

  @endpoint "balance"

  @doc """
  Retrieves the current account balance.

  This is based on the authentication that was used to make the request.

  See the [Stripe docs](https://stripe.com/docs/api#retrieve_balance).
  """
  @spec retrieve(Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
  def retrieve(opts \\ []) do
    new_request(opts)
    |> put_endpoint(@endpoint)
    |> put_method(:get)
    |> make_request()
  end
end
