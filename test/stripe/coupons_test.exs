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

  @tags disabled: false
  test "Create coupon success" do
    use_cassette "coupons_test/create", match_requests_on: [:query, :request_body] do
      opts = [
        duration: "forever",
        id: "DISCOUNT20",
        percent_off: 25
      ]

      {:ok, res} = Stripe.Coupons.create(opts)

      assert res
      assert res.id === "DISCOUNT20"
      assert res.duration === "forever"
      assert res.created
      assert res.percent_off === 25
      assert res.valid === true
      assert res.times_redeemed === 0
      assert is_nil(res.amount_off)
      assert is_nil(res.currency)
      assert is_nil(res.duration_in_months)
      assert is_nil(res.max_redemptions)
      assert is_nil(res.redeem_by)
    end
  end

  @tags disabled: false
  test "Create coupon without duration fails" do
    use_cassette "coupons_test/create_failure", match_requests_on: [:query, :request_body] do
      opts = [id: "DISCOUNT20"]

      {:error, err} = Stripe.Coupons.create(opts)

      assert err["error"]["message"] === "Missing required param: duration."
    end
  end

end
