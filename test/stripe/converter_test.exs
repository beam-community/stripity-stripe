defmodule Stripe.ConverterTest do
  use ExUnit.Case

  alias Stripe.Converter

  test "converts a 'customer.updated' event response properly" do
    expected_result = %Stripe.Event{
      api_version: "2016-07-06",
      created: 1483537031,
      data: %{
        object: %Stripe.Customer{
          id: "cus_9ryX7lUQ4Dcpf7",
          object: "customer",
          account_balance: 0,
          business_vat_id: nil,
          created: 1483535628,
          currency: nil,
          default_source: nil,
          delinquent: false,
          description: nil,
          email: "test2@mail.com",
          livemode: false,
          metadata: %{},
          sources: %Stripe.List{
            object: "list",
            data: [],
            has_more: false,
            total_count: 0,
            url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/sources"
          },
          subscriptions: %Stripe.List{
            object: "list",
            data: [],
            has_more: false,
            total_count: 0,
            url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/subscriptions"
          }
        },
        previous_attributes: %{
          description: "testcustomer",
          email: "test@mail.com",
          metadata: %{test: "key"}
        }
      },
      id: "evt_19YEx1BKl1F6IRFfb1cFLHzZ",
      livemode: false,
      object: "event",
      pending_webhooks: 0,
      request: "req_9ryusbEBenV0BX",
      type: "customer.updated",
      user_id: nil
    }

    fixture = Helper.load_fixture("event_with_customer.json")
    result = Converter.stripe_map_to_struct(fixture)

    assert result == expected_result
  end

  test "converts a list response properly" do
    expected_result = %Stripe.List{
      object: "list",
      data: [
        %Stripe.Card{
          id: "card_19YDiuBKl1F6IRFflldIp6Dc",
          object: "card",
          address_city: nil,
          address_country: nil,
          address_line1: nil,
          address_line1_check: nil,
          address_line2: nil,
          address_state: nil,
          address_zip: nil,
          address_zip_check: nil,
          brand: "Visa",
          country: "US",
          customer: "cus_9ryX7lUQ4Dcpf7",
          cvc_check: nil,
          dynamic_last4: nil,
          exp_month: 8,
          exp_year: 2018,
          funding: "credit",
          last4: "4242",
          metadata: %{},
          name: nil,
          tokenization_method: nil
        },
        %Stripe.Card{
          id: "card_abcdiuBKl1F6IRFflldIp6Dc",
          object: "card",
          address_city: nil,
          address_country: nil,
          address_line1: nil,
          address_line1_check: nil,
          address_line2: nil,
          address_state: nil,
          address_zip: nil,
          address_zip_check: nil,
          brand: "Visa",
          country: "US",
          customer: "cus_9ryX7lUQ4Dcpf7",
          cvc_check: nil,
          dynamic_last4: nil,
          exp_month: 12,
          exp_year: 2020,
          funding: "credit",
          last4: "4242",
          metadata: %{},
          name: nil,
          tokenization_method: nil
        }
      ],
      has_more: false,
      total_count: 2,
      url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/sources"
    }

    fixture = Helper.load_fixture("card_list.json")
    result = Converter.stripe_map_to_struct(fixture)

    assert result == expected_result
  end

  test "converts a customer response with a list of sources properly" do
    expected_result = %Stripe.Customer{
      id: "cus_9ryX7lUQ4Dcpf7",
      object: "customer",
      account_balance: 0,
      created: 1483535628,
      currency: "usd",
      default_source: nil,
      delinquent: false,
      description: nil,
      discount: nil,
      email: "test2@mail.com",
      livemode: false,
      metadata: %{},
      shipping: nil,
      sources: %Stripe.List{
        object: "list",
        data: [],
        has_more: false,
        total_count: 0,
        url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/sources"
      },
      subscriptions: %Stripe.List{
        object: "list",
        data: [],
        has_more: false,
        total_count: 0,
        url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/subscriptions"
      }
    }

    fixture = Helper.load_fixture("customer.json")
    result = Converter.stripe_map_to_struct(fixture)

    assert result == expected_result
  end
end
