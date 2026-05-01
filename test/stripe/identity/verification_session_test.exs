defmodule Stripe.Identity.VerificationSessionTest do
  use Stripe.StripeCase, async: true

  alias Stripe.Identity.VerificationSession

  test "is creatable" do
    assert {:ok, %VerificationSession{}} =
             VerificationSession.create(%{type: "document"})

    assert_stripe_requested(:post, "/v1/identity/verification_sessions")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: verification_sessions}} =
             VerificationSession.list()

    assert_stripe_requested(:get, "/v1/identity/verification_sessions")
    assert is_list(verification_sessions)
    assert %VerificationSession{} = hd(verification_sessions)
  end

  test "is retrievable" do
    assert {:ok, %VerificationSession{}} =
             VerificationSession.retrieve("vs_123xxx")

    assert_stripe_requested(:get, "/v1/identity/verification_sessions/vs_123xxx")
  end

  test "is updatable" do
    assert {:ok, %VerificationSession{}} =
             VerificationSession.update("vs_123xxx", %{type: "document"})

    assert_stripe_requested(:post, "/v1/identity/verification_sessions/vs_123xxx")
  end

  test "is cancelable" do
    assert {:ok, %VerificationSession{}} =
             VerificationSession.cancel("vs_123xxx")

    assert_stripe_requested(:post, "/v1/identity/verification_sessions/vs_123xxx/cancel")
  end

  test "is redactable" do
    assert {:ok, %VerificationSession{}} =
             VerificationSession.redact("vs_123xxx")

    assert_stripe_requested(:post, "/v1/identity/verification_sessions/vs_123xxx/redact")
  end
end
