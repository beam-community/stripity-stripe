defmodule Stripe.ErrorTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Stripe.Error

  describe "from_stripe_error/3" do
    test "works with no error data" do
      error = Error.from_stripe_error(400, nil, "id")
      assert error.code == :bad_request
      assert error.extra.http_status == 400

      message = "The request was unacceptable, often due to missing a required parameter."
      assert error.message == message

      assert error.request_id == "id"
      assert error.source == :stripe
      assert error.user_message == nil
    end

    test "works with an invalid request error due to an unexpected param" do
      error_data = %{
        "message" => "Received unknown parameter: type",
        "param" => "type",
        "type" => "invalid_request_error"
      }

      error = Error.from_stripe_error(400, error_data, "id")
      assert error.code == :invalid_request_error
      assert error.extra.http_status == 400
      assert error.extra.param == :type
      assert error.extra.raw_error == error_data
      assert error.message == "Received unknown parameter: type"
      assert error.request_id == "id"
      assert error.source == :stripe
      assert error.user_message == nil
    end

    test "generates message if error payload does not have one" do
      error_data = %{
        "type" => "invalid_request_error"
      }

      error = Error.from_stripe_error(400, error_data, "id")
      assert error.code == :invalid_request_error
      assert error.extra.http_status == 400
      assert error.extra.raw_error == error_data
      assert error.message == "Your request had invalid parameters."
      assert error.request_id == "id"
      assert error.source == :stripe
      assert error.user_message == nil
    end
  end
end
