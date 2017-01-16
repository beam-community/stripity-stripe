defmodule Stripe.ConverterTest do
  use ExUnit.Case

  alias Stripe.Converter
  alias Stripe.ConverterTest

  defmodule Person do
    defstruct [:email, :first_name, :last_name, :legal_entity, :metadata]
  end

  defmodule AuthToken do
    defstruct [:id, :card, :client_ip, :created, :livemode, :type, :used]
  end

  test "converts a response into a struct" do
    expected_result = %Stripe.ConverterTest.Person{
      first_name: "Leslie",
      last_name: "Knope",
      email: "knope@stripe.com",
      metadata: %{},
      legal_entity: %{
        address: %{
          city: "Pawnee",
          country: "US",
          state: "IN"
        },
        business_name: "Parks and Rec",
        dob: %{
          day: 23,
          month: 12,
          year: 2016
        }
      }
    }

    result = Converter.stripe_map_to_struct(ConverterTest.Person, json_response)
    assert result == expected_result
  end

  defp json_response do
    %{
      "first_name" => "Leslie",
      "last_name" => "Knope",
      "email" => "knope@stripe.com",
      "metadata" => %{},
      "legal_entity" => %{
        "address" => %{
          "city" => "Pawnee",
          "country" => "US",
          "state" => "IN"
        },
        "business_name" => "Parks and Rec",
        "dob" => %{
          "day" => 23,
          "month" => 12,
          "year" => 2016
        }
      }
    }
  end

  test "converts a stripe card sub-object into a struct" do
    expected_result = %Stripe.ConverterTest.AuthToken{
      id: "token_id",
      used: false,
      card: %Stripe.Card{
        brand: "Visa",
        country: "US",
        exp_month: 8
      },
      created: 1462905445
    }

    result = Converter.stripe_map_to_struct(
      ConverterTest.AuthToken, json_response_with_card_subobject
    )
    assert result == expected_result
  end

  defp json_response_with_card_subobject do
    %{
      "id" => "token_id",
      "used" => false,
      "created" => 1462905445,
      "card" => %{
        "object" => "card",
        "brand" => "Visa",
        "country" => "US",
        "exp_month" => 8,
      }
    }
  end

  test "converts an object containing another object properly" do
    expected_result = %Stripe.Event{
      api_version: "2016-07-06",
      created: 1483537031,
      data: %{
        object: %Stripe.Customer{
          account_balance: 0,
          business_vat_id: nil,
          created: 1483535628,
          currency: nil,
          default_source: nil,
          delinquent: false,
          description: nil,
          email: "test2@mail.com",
          id: "cus_9ryX7lUQ4Dcpf7",
          livemode: false,
          metadata: %{},
          sources: %Stripe.List{
            data: [],
            has_more: false,
            total_count: 0,
            url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/sources"
          },
          subscriptions: %Stripe.List{
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
    result = Converter.stripe_map_to_struct(Stripe.Event, fixture)

    assert result == expected_result
  end

  test "converts a list response properly" do
    expected_result = %Stripe.List{
      data: [
        %Stripe.Card{
          id: "card_19YDiuBKl1F6IRFflldIp6Dc",
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
    result = Converter.stripe_map_to_struct(Stripe.List, fixture)

    assert result == expected_result
  end

  test "converts an object containing a list properly" do
    expected_result = %Stripe.Customer{
      id: "cus_9ryX7lUQ4Dcpf7",
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
        data: [],
        has_more: false,
        total_count: 0,
        url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/sources"
      },
      subscriptions: %Stripe.List{
        data: [],
        has_more: false,
        total_count: 0,
        url: "/v1/customers/cus_9ryX7lUQ4Dcpf7/subscriptions"
      }
    }

    fixture = Helper.load_fixture("customer.json")
    result = Converter.stripe_map_to_struct(Stripe.Customer, fixture)

    assert result == expected_result
  end
end
