defmodule Stripe.ApplePayDomainTest do
  use Stripe.StripeCase

# Uncommenting below breaks compilation of whole test suite
# TODO: Uncomment once Stripe.ApplePayDomain is implemented

#  test "is listable" do
#    assert {:ok, %Stripe.List{data: domains}} = Stripe.ApplePayDomain.list()
#    assert_stripe_requested :get, "/v1/apple_pay/domains"
#    assert is_list(domains)
#    assert %Stripe.ApplePayDomain{} = hd(domains)
#  end
#
#  test "is retrievable" do
#    assert {:ok, %Stripe.ApplePayDomain{}} = Stripe.ApplePayDomain.retrieve("apwc_123")
#    assert_stripe_requested :get, "/v1/apple_pay/domains/apwc_123"
#  end
#
#  test "is creatable" do
#    assert {:ok, %Stripe.ApplePayDomain{}} = Stripe.ApplePayDomain.create(%{domain_name: "example.com"})
#    assert_stripe_requested :post, "/v1/apple_pay/domains"
#  end
#
#  @tag :reset_stripe_after
#  test "is deletable" do
#    {:ok, domain} = Stripe.ApplePayDomain.retrieve("apwc_123")
#    assert :ok = Stripe.ApplePayDomain.delete(domain)
#    assert_stripe_requested :delete, "/v1/apple_pay/domains/#{domain.id}"
#  end
end
