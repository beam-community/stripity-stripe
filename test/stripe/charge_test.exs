defmodule Stripe.ChargeTest do
  use ExUnit.Case

  setup do
    params = [
      source: [
        object: "card",
        number: "4111111111111111",
        exp_month: 10,
        exp_year: 2020,
        country: "US",
        name: "Ducky Test",
        cvc: 123
      ],
      description: "1000 Widgets"
    ]
    {:ok, [params: params]}
  end

  test "A valid charge is successful with card as source", %{params: params} do

    case Stripe.Charges.create(1000,params) do
      {:ok, res} -> assert res.id
      {:error, err} -> flunk err
    end
  end

  test "Listing returns charges" do
    case Stripe.Charges.list() do
      {:ok, charges} -> assert length(charges) > 0
      {:error, err} -> flunk err
    end
  end

  test "Getting a charge" do
    {:ok,[first | _]} = Stripe.Charges.list()
    case Stripe.Charges.get(first.id) do
      {:ok, charge} -> assert charge.id == first.id
      {:error, err} -> flunk err
    end
  end

  test "Capturing a charge", %{params: params} do
    params = Keyword.put_new params, :capture, false
    {:ok, charge} = Stripe.Charges.create(1000,params)
    case Stripe.Charges.capture(charge.id) do
      {:ok, captured} -> assert captured.id == charge.id
      {:error, err} -> flunk err
    end
  end

  test "Changing a charge", %{params: params} do
    {:ok, charge} = Stripe.Charges.create(1000,params)
    params = [description: "Changed charge"]
    case Stripe.Charges.change(charge.id, params) do
      {:ok, changed} -> assert changed.description == "Changed charge"
      {:error, err} -> flunk err
    end
  end

  test "Refunding a charge", %{params: params} do
    {:ok, charge} = Stripe.Charges.create(1000,params)
    case Stripe.Charges.refund_partial(charge.id,500) do
      {:ok, refunded} -> assert refunded.amount == 500
      {:error, err} -> flunk err
    end
  end
end
