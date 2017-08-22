defmodule Stripe.Balance do
  @moduledoc """
  Work with [Stripe `balance` objects](https://stripe.com/docs/api#balance).

  You can:
  - [Retrieve the current balance](https://stripe.com/docs/api#retrieve_balance)

  """
  @type funds :: %{
                   currency: String.t,
                   amount: integer,
                   source_types: %{
                     Stripe.Source.source_type => integer
                   }
                 }

  @type t :: %__MODULE__{
               object: String.t,
               available: [funds],
               livemode: boolean,
               pending: [funds]
             }

  defstruct [:object, :available, :connect_reserved, :livemode, :pending]

  @endpoint "balance"

  @doc """
  Retrieves the current account balance, based on the authentication that was used to make the request.
  """
  @spec retrieve(Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
  def retrieve(opts \\ []) do
    Stripe.Request.retrieve(%{}, @endpoint, nil, opts)
  end
end
