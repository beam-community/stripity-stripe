defmodule Stripe.WebhookHandler do
  @moduledoc """
  Webhook handler specification.
  See `Stripe.WebhookPlug` for more details.
  """
  @type error_reason :: binary() | atom()

  @doc "Handles a Stripe webhook event within your application."
  @callback handle_event(event :: Stripe.Event.t()) ::
              {:ok, term} | :ok | {:error, error_reason} | :error
end
