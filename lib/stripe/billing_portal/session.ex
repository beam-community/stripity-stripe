defmodule Stripe.BillingPortal.Session do
  @moduledoc """
  Work with Stripe Billing (aka Self-serve) Portal Session objects.

  You can:

  - Create a session

  Stripe API reference: https://stripe.com/docs/api/customer_portal
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          :id => Stripe.id(),
          :object => String.t(),
          :created => Stripe.timestamp(),
          :customer => Stripe.id() | Stripe.Customer.t(),
          :livemode => boolean(),
          :return_url => String.t(),
          :url => String.t()
        }

  @type create_params :: %{
          :customer => String.t(),
          optional(:return_url) => String.t()
        }

  defstruct [
    :id,
    :object,
    :created,
    :customer,
    :livemode,
    :return_url,
    :url
  ]

  @plural_endpoint "billing_portal/sessions"

  @spec create(create_params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end
end
