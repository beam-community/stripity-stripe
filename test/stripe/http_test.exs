defmodule Stripe.HTTPTest do
  use ExUnit.Case, async: true

  describe "resolve_http_module/0" do
    setup do
      original = Application.get_env(:stripity_stripe, :http_module)

      on_exit(fn ->
        if original do
          Application.put_env(:stripity_stripe, :http_module, original)
        else
          Application.delete_env(:stripity_stripe, :http_module)
        end
      end)

      :ok
    end

    test "returns configured module when explicitly set" do
      Application.put_env(:stripity_stripe, :http_module, Stripe.HTTP.Hackney)
      assert Stripe.HTTP.resolve_http_module() == Stripe.HTTP.Hackney
    end

    test "maps raw :hackney atom to Stripe.HTTP.Hackney with deprecation warning" do
      Application.put_env(:stripity_stripe, :http_module, :hackney)

      assert ExUnit.CaptureIO.capture_io(:stderr, fn ->
               assert Stripe.HTTP.resolve_http_module() == Stripe.HTTP.Hackney
             end) =~ "deprecated"
    end

    test "auto-detects hackney when no config is set" do
      Application.delete_env(:stripity_stripe, :http_module)
      # hackney is available in our test deps
      assert Stripe.HTTP.resolve_http_module() == Stripe.HTTP.Hackney
    end
  end
end
