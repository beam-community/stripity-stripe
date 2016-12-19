defmodule Stripe.ConverterTest do
  use ExUnit.Case

  alias Stripe.Converter

  defmodule Person do
    defstruct [:email, :first_name, :last_name, :legal_entity, :metadata]
    def relationships, do: %{}
  end

  defmodule PersonWithMissingRelationship do
    defstruct [:card]
    def relationships, do: %{card: Stripe.ConverterTest.CreditCard}
  end

  defmodule AuthToken do
    defstruct [:id, :card, :client_ip, :created, :livemode, :type, :used]
    def relationships, do: %{
      card: Stripe.ConverterTest.CreditCard,
      created: DateTime
    }
  end

  defmodule CreditCard do
    defstruct [:brand, :country, :exp_month]
    def relationships, do: %{}
  end

  test "converts a Stripe response into a struct" do
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

    result = Converter.stripe_map_to_struct(Stripe.ConverterTest.Person, json_response)
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

  test "converts relationship keys into a struct" do
    expected_result = %Stripe.ConverterTest.AuthToken{
      id: "token_id",
      used: false,
      card: %Stripe.ConverterTest.CreditCard{
        brand: "Visa",
        country: "US",
        exp_month: 8
      },
      created: %DateTime{
        calendar: Calendar.ISO,
        day: 10,
        hour: 18,
        microsecond: {0, 0},
        minute: 37,
        month: 5,
        second: 25,
        std_offset: 0,
        time_zone: "Etc/UTC",
        utc_offset: 0,
        year: 2016,
        zone_abbr: "UTC"
      }
    }

    result = Converter.stripe_map_to_struct(
      Stripe.ConverterTest.AuthToken, json_response_with_relationship
    )
    assert result == expected_result
  end

  defp json_response_with_relationship do
    %{
      "id" => "token_id",
      "used" => false,
      "created" => 1462905445,
      "card" => %{
        "brand" => "Visa",
        "country" => "US",
        "exp_month" => 8,
      }
    }
  end

  test "returns nil when a specified relationship is not in the Stripe response" do
    expected_result = %Stripe.ConverterTest.PersonWithMissingRelationship{
      card: nil
    }

    result = Converter.stripe_map_to_struct(Stripe.ConverterTest.PersonWithMissingRelationship, json_response)
    assert result == expected_result
  end
end
