defmodule Stripe.RequestTest do
  use ExUnit.Case

  alias Stripe.Request

  describe "object expansion" do
    test "prefix_expansions/2 should apply the given prefix to the expansion values" do
      opts = [expand: ["balance_transaction"]]
      request = Request.prefix_expansions(%Request{opts: opts})
      expansions = Keyword.get(request.opts, :expand)

      assert expansions == ["data.balance_transaction"]
    end

    test "prefix_expansions/2 should apply the given prefix to multiple expansion values" do
      opts = [expand: ["balance_transaction", "customer"]]
      request = Request.prefix_expansions(%Request{opts: opts})
      expansions = Keyword.get(request.opts, :expand)

      assert expansions == ["data.balance_transaction", "data.customer"]
    end

    test "prefix_expansions/2 should return the original opts if no expansions specified" do
      opts = []
      request = Request.prefix_expansions(%Request{opts: opts})

      assert request.opts == opts
    end
  end
end
