defmodule Stripe.Plans do
  @moduledoc """
  Basic List, Create, Delete API for Plans
  """

  @endpoint "plans"

  @doc """
  Creates a Plan. Note that `currency` and `interval` are required parameters, and are defaulted to "USD" and "month"

  ## Example
    {:ok, plan} = Stripe.Plans.create [id: "test-plan", name: "Test Plan", amount: 1000, interval: "month"]
  """
  def create(params) do

    #default the currency and interval
    params = Keyword.put_new params, :currency, "USD"
    params = Keyword.put_new params, :interval, "month"

    Stripe.make_request(:post, @endpoint, params)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns a list of Plans.
  """
  def list(limit \\ 10) do
    Stripe.make_request(:get, "#{@endpoint}?limit=#{limit}")
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Deletes a Plan with the specified ID.

  ## Example
    {:ok, res} = Stripe.Plans.delete "test-plan"
  """
  def delete(id) do
    Stripe.make_request(:delete, "#{@endpoint}/#{id}")
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Changes Plan information. See Stripe docs as to what you can change.

  ## Example
    {:ok, plan} = Stripe.Plans.change("test-plan",[name: "Other Plan"])
  """
  def change(id, params) do
    Stripe.make_request(:post, "#{@endpoint}/#{id}", params)
      |> Stripe.Util.handle_stripe_response
  end
end
