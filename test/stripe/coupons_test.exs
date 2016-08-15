defmodule Stripe.CouponsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @tags disabled: false
  test "Validate coupon with coupon id" do
    use_cassette "coupons_test/retrieve", match_requests_on: [:query, :request_body] do
      params = "free-1-month"

      case Stripe.Coupons.retrieve(params) do
        {:ok, res} ->
          assert res.id == params
        {:error, err} -> flunk err
      end
    end
  end
end
