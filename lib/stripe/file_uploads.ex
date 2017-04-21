defmodule Stripe.FileUploads do
  @moduledoc """
  Main API for working with FileUploads at Stripe. Through this API you can:
  -create

  All calls have a version with accept a key parameter for leveraging Connect.

  (API ref:https://stripe.com/docs/api#file_uploads) 
  """

  @endpoint "files"

  @doc """
  Create file_upload according to Stripe's file_upload rules.

  ## Example

  ```
  {:ok, file_upload} = Stripe.FileUploads.create "customer_id", params
  ```
  """
  def create(params) do
    create params, Stripe.config_or_env_key
  end

  @doc """
  Create file_upload according to Stripe's file_upload rules. This is not the same as a charge.
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  {:ok, file_upload} = Stripe.FileUploads.create "customer_id", params, key
  ```
  """
  def create(params, key) do
    Stripe.make_request_with_key(:post, @endpoint, key, params)
    |> Stripe.Util.handle_stripe_response
  end

end
