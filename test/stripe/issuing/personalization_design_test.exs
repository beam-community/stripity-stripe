defmodule Stripe.Issuing.PersonalizationDesignTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      name: "Test Design",
      physical_bundle: "pb_123",
      carrier_text: %{
        header_title: "Welcome",
        header_body: "Your new card is here"
      }
    }

    assert {:ok, %Stripe.Issuing.PersonalizationDesign{}} =
             Stripe.Issuing.PersonalizationDesign.create(params)

    assert_stripe_requested(:post, "/v1/issuing/personalization_designs")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.PersonalizationDesign{}} =
             Stripe.Issuing.PersonalizationDesign.retrieve("pd_123")

    assert_stripe_requested(:get, "/v1/issuing/personalization_designs/pd_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: designs}} =
             Stripe.Issuing.PersonalizationDesign.list()

    assert_stripe_requested(:get, "/v1/issuing/personalization_designs")
    assert is_list(designs)
    assert %Stripe.Issuing.PersonalizationDesign{} = hd(designs)
  end

  test "is listable with status filter" do
    params = %{
      status: :active
    }

    assert {:ok, %Stripe.List{data: designs}} =
             Stripe.Issuing.PersonalizationDesign.list(params)

    assert_stripe_requested(:get, "/v1/issuing/personalization_designs", query: params)
    assert is_list(designs)
    assert %Stripe.Issuing.PersonalizationDesign{} = hd(designs)
  end

  test "is updateable" do
    params = %{
      name: "Updated Design",
      carrier_text: %{
        header_title: "Updated Welcome",
        header_body: "Your updated card is here"
      }
    }

    assert {:ok, %Stripe.Issuing.PersonalizationDesign{}} =
             Stripe.Issuing.PersonalizationDesign.update("pd_123", params)

    assert_stripe_requested(:post, "/v1/issuing/personalization_designs/pd_123")
  end

  test "test helpers: can be activated" do
    assert {:ok, %Stripe.Issuing.PersonalizationDesign{}} =
             Stripe.Issuing.PersonalizationDesign.activate("pd_123")

    assert_stripe_requested(
      :post,
      "/v1/test_helpers/issuing/personalization_designs/pd_123/activate"
    )
  end

  test "test helpers: can be deactivated" do
    assert {:ok, %Stripe.Issuing.PersonalizationDesign{}} =
             Stripe.Issuing.PersonalizationDesign.deactivate("pd_123")

    assert_stripe_requested(
      :post,
      "/v1/test_helpers/issuing/personalization_designs/pd_123/deactivate"
    )
  end

  test "test helpers: can be rejected" do
    params = %{
      rejection_reasons: %{
        card_logo: [:inappropriate]
      }
    }

    assert {:ok, %Stripe.Issuing.PersonalizationDesign{}} =
             Stripe.Issuing.PersonalizationDesign.reject("pd_123", params)

    assert_stripe_requested(
      :post,
      "/v1/test_helpers/issuing/personalization_designs/pd_123/reject"
    )
  end
end
