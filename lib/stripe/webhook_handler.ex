defmodule Stripe.WebhookHandler do
  @moduledoc """
  Webhook handler specification.
  See `Stripe.WebhookPlug` for more details.
  """

  @doc "Handles a Stripe webhook event within your application."
  @callback handle_event(event :: Stripe.Event.t()) :: {:ok, term} | :ok
end
