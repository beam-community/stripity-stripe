defmodule Stripe.Mandate do
  @moduledoc """
  A [Mandate](https://stripe.com/docs/api/mandates) is a record of the
  permission a customer has given you to debit their payment method.

   You can:
  - [Retrieve a Mandate](https://stripe.com/docs/api/mandates/retrieve)
  """

  use Stripe.Entity
  import Stripe.Request

  @type customer_acceptance :: %{
          required(:accepted_at) => Stripe.timestamp(),
          optional(:offline) =>
            %{
              # The docs lists this a hash with no attributes.
            },
          optional(:online) => %{
            ip_address: String.t(),
            user_agent: String.t()
          },
          required(:type) => String.t()
        }

  @type payment_method_details :: %{
          optional(:au_becs_debit) => %{
            url: String.t()
          },
          optional(:card) =>
            %{
              # The docs list this as a hash with no attributes.
            },
          optional(:sepa_debit) => %{
            reference: String.t(),
            url: String.t()
          },
          type: String.t()
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          customer_acceptance: customer_acceptance(),
          livemode: boolean,
          multi_use: map,
          payment_method: Stripe.id() | Stripe.PaymentMethod.t() | nil,
          payment_method_details: payment_method_details(),
          status: String.t(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :customer_acceptance,
    :livemode,
    :multi_use,
    :payment_method,
    :payment_method_details,
    :status,
    :type
  ]

  @plural_endpoint "mandates"

  @doc """
  Retrieves a Mandate that has previously been created.
  See the [Stripe docs](https://stripe.com/docs/api/mandates/retrieve).
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end
end
