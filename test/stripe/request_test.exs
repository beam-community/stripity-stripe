defmodule Stripe.RequestTest do
  use ExUnit.Case

  describe "retrieve_all/2" do
    test "handles raised errors accurately" do
      opts = []
      retrieve_many = fn _ -> {:error, "error"} end
      result = Stripe.Request.retrieve_all(retrieve_many, opts)
      assert result == {:error, "error"}
    end
  end
end
