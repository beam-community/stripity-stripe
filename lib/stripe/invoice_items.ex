defmodule Stripe.InvoiceItems do
  @moduledoc """
  The API for tacking on charges to subscriptions. See Stripe docs for more details.
  """

  @endpoint "invoiceitems"

  @doc """
  Returns a list of InvoiceItems
  """
  def list do
    Stripe.make_request(:get, @endpoint)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Creates an InvoiceItem for a Customer/Subscription 
  """
  def create(params) do
    Stripe.make_request_with_key(:post, @endpoint, Stripe.config_or_env_key, params)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Retrieves the invoice item with the given ID.

  ## Arguments

  - `id` - `String` - (required) - The ID of the desired invoice item.

  ## Returns

  Returns an invoice item if a valid invoice item ID was provided. Returns
  an error otherwise.
  """
  def retrieve(id) do
    Stripe.make_request(:get, @endpoint <> "/#{id}")
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Updates the amount or description of an invoice item on an upcoming invoice.
  Updating an invoice item is only possible before the invoice it's attached
  to is closed.

  ## Arguments

  - `amount` - `Integer` - (required) - The integer amount in cents of
      the charge to be applied to the upcoming invoice. If you want to
      apply a credit to the customer's account, pass a negative amount.
  - `description` - `String` - (optional), default is `null` - An arbitrary
      string which you can attach to the invoice item. The description is
      displayed in the invoice for easy tracking.
  - `metadata` - `Keyword` - (optional), default is `[]` - A set of
      key/value pairs that you can attach to an invoice item object. It can
      be useful for storing additional information about the invoice item in
      a structured format.

  ## Returns

  The updated invoice item object is returned upon success. Otherwise, this
  call returns an error.
  """
  def update(params) do
    Stripe.make_request(:post, @endpoint <> "/#{params[:id]}", params)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Removes an invoice item from the upcoming invoice. Removing an invoice
  item is only possible before the invoice it's attached to is closed.

  ## Arguments

  - `id` - `String` - (required) - The ID of the desired invoice item.

  ## Returns

  An object with the deleted invoice item's ID and a deleted flag upon
  success. This call returns an error otherwise, such as when the invoice
  item has already been deleted.
  """
  def delete(id) do
    Stripe.make_request(:delete, @endpoint <> "/#{id}")
      |> Stripe.Util.handle_stripe_response
  end
end
