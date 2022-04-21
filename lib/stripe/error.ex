defmodule Stripe.Error do
  @moduledoc """
  A struct which represents an error which occurred during a Stripe API call.

  This struct is designed to provide all the information needed to effectively log and maybe respond
  to an error.

  It contains the following fields:
  - `:source` – this is one of
    * `:internal` – the error occurred within the library. This is usually caused by an unexpected
      or missing parameter.
    * `:network` – the error occurred while making the network request (i.e. `:hackney.request/5`
      returned an error.) In this case, `:code` will always be `:network_error`. The
      `:hackney_reason` field in the `:extra` map contains the actual error reason received from
      hackney.
    * `:stripe` – an error response was received from Stripe.
  - `:code` – an atom indicating the particular error. See "Error Codes" for more detail.
  - `:request_id` – if `:source` is `:stripe`, this will contain the
    [request ID](https://stripe.com/docs/api#request_ids) for logging and troubleshooting.
    Otherwise, this field is `nil`.
  - `:message` – a loggable message describing the error. This should not be shown to your users
    but is intended for logging and troubleshooting.
  - `:user_message` – if Stripe has provided a user-facing message (e.g. when a card is declined),
    this field will contain it. Otherwise it is `nil`.
  - `:extra` - a map which may contain some additional information about the error. See "Extra
    Fields" for details.

  ## Extra Fields
  The `:extra` field contains a map of miscellaneous information about the error which may be
  useful. The fields are not present if not relevant. The possible fields are:
  - `:card_code` – when `:code` is `:card_error`, contains one of Stripe's
    [decline reasons](https://stripe.com/docs/api#errors).
  - `:decline_code` – an optional short string provided by the bank when a card is declined.
  - `:param` – for errors where a particular parameter was the cause, indicates which parameter
    was invalid.
  - `:charge_id` – when a Charge was declined, indicates the ID of the failed Charge which was
    created.
  - `:http_status` – for `:stripe` errors, the HTTP status returned with the error.
  - `:raw_error` – the raw error map received from Stripe.
  - `:hackney_reason` – for `:network` errors, contains the error reason received from hackney.

  ## Error Codes
  The `:code` fields may be one of the following:
  - `:api_connection_error`, `:api_error`, `:authentication_error`, `:card_error`,
    `:invalid_request_error`, `:rate_limit_error`, `:validation_error` – as per the
    [Stripe docs](https://stripe.com/docs/api#errors)
  - `:bad_request`, `:unauthorized`, `:request_failed`, `:not_found`, `:conflict`,
    `:too_many_requests`, `:server_error`, `:unknown_error` – these only occur if Stripe did not
    send an explicit `type` for the error. They have the meaning as defined in [Stripe's HTTP status
    code summary](https://stripe.com/docs/api#errors)
  - `:network_code` – used only when `:source` is `:network`. Indicates an error occurred while
    making the request.
  - `:valid_keys_failed`, `:required_keys_failed`, `:endpoint_fun_invalid_result`,
    `:invalid_endpoint` – used when `:source` is `:internal`. See `Stripe.Request` for details.
  """

  @type error_source :: :internal | :network | :stripe

  @type error_status ::
          :bad_request
          | :unauthorized
          | :request_failed
          | :not_found
          | :conflict
          | :too_many_requests
          | :server_error
          | :unknown_error

  @type stripe_error_type ::
          :api_connection_error
          | :api_error
          | :authentication_error
          | :card_error
          | :invalid_request_error
          | :rate_limit_error
          | :validation_error

  @type card_error_code ::
          :invalid_number
          | :invalid_expiry_month
          | :invalid_expiry_year
          | :invalid_cvc
          | :invalid_swipe_data
          | :incorrect_number
          | :expired_card
          | :incorrect_cvc
          | :incorrect_zip
          | :card_declined
          | :missing
          | :processing_error
          | :bank_account_verification_failed

  @type t :: %__MODULE__{
          source: error_source,
          code: error_status | stripe_error_type | Stripe.Request.error_code() | :network_error,
          request_id: String.t() | nil,
          message: String.t(),
          user_message: String.t() | nil,
          extra: %{
            optional(:card_code) => card_error_code,
            optional(:decline_code) => String.t(),
            optional(:param) => atom,
            optional(:charge_id) => Stripe.id(),
            optional(:http_status) => 400..599,
            optional(:raw_error) => map,
            optional(:hackney_reason) => any
          }
        }

  @enforce_keys [:source, :code, :message]
  defstruct [:source, :code, :request_id, :extra, :message, :user_message]

  @doc false
  @spec new(Keyword.t()) :: t
  def new(fields) do
    struct!(__MODULE__, fields)
  end

  @doc false
  @spec from_hackney_error(any) :: t
  def from_hackney_error(reason) do
    %__MODULE__{
      source: :network,
      code: :network_error,
      message:
        "An error occurred while making the network request. The HTTP client returned the following reason: #{
          inspect(reason)
        }",
      extra: %{
        hackney_reason: reason
      }
    }
  end

  @doc false
  @spec from_stripe_error(400..599, nil, String.t() | nil) :: t
  def from_stripe_error(status, nil, request_id) do
    %__MODULE__{
      source: :stripe,
      code: code_from_status(status),
      request_id: request_id,
      extra: %{http_status: status},
      message: status |> message_from_status()
    }
  end

  @spec from_stripe_error(400..599, map, String.t()) :: t
  def from_stripe_error(status, error_data, request_id) do
    case error_data |> Map.get("type") |> maybe_to_atom() do
      nil ->
        from_stripe_error(status, nil, request_id)

      type ->
        stripe_message = error_data |> Map.get("message")

        user_message =
          case type do
            :card_error -> stripe_message
            _ -> nil
          end

        message = stripe_message || message_from_type(type)

        extra =
          %{raw_error: error_data, http_status: status}
          |> maybe_put(:card_code, error_data |> Map.get("code") |> maybe_to_atom())
          |> maybe_put(:decline_code, error_data |> Map.get("decline_code"))
          |> maybe_put(:param, error_data |> Map.get("param") |> maybe_to_atom())
          |> maybe_put(:charge_id, error_data |> Map.get("charge"))

        %__MODULE__{
          source: :stripe,
          code: type,
          request_id: request_id,
          message: message,
          user_message: user_message,
          extra: extra
        }
    end
  end

  defp code_from_status(400), do: :bad_request
  defp code_from_status(401), do: :unauthorized
  defp code_from_status(402), do: :request_failed
  defp code_from_status(404), do: :not_found
  defp code_from_status(409), do: :conflict
  defp code_from_status(429), do: :too_many_requests
  defp code_from_status(s) when s in [500, 502, 503, 504], do: :server_error
  defp code_from_status(_), do: :unknown_error

  defp message_from_status(400),
    do: "The request was unacceptable, often due to missing a required parameter."

  defp message_from_status(401), do: "No valid API key provided."
  defp message_from_status(402), do: "The parameters were valid but the request failed."
  defp message_from_status(404), do: "The requested resource doesn't exist."

  defp message_from_status(409),
    do:
      "The request conflicts with another request (perhaps due to using the same idempotent key)."

  defp message_from_status(429),
    do:
      "Too many requests hit the API too quickly. We recommend an exponential backoff of your requests."

  defp message_from_status(s) when s in [500, 502, 503, 504],
    do: "Something went wrong on Stripe's end."

  defp message_from_status(s), do: "An unknown HTTP code of #{s} was received."

  defp message_from_type(:api_connection_error), do: "The connection to Stripe's API failed."

  defp message_from_type(:api_error),
    do: "An internal Stripe error occurred. This is usually temporary."

  defp message_from_type(:authentication_error),
    do: "You failed to properly authenticate yourself in the request."

  defp message_from_type(:card_error), do: "The card could not be charged for some reason."
  defp message_from_type(:invalid_request_error), do: "Your request had invalid parameters."

  defp message_from_type(:rate_limit_error),
    do:
      "Too many requests hit the API too quickly. We recommend an exponential backoff of your requests."

  defp message_from_type(:validation_error),
    do: "A client-side library failed to validate a field."

  defp maybe_put(map, _key, nil), do: map
  defp maybe_put(map, key, value), do: map |> Map.put(key, value)

  defp maybe_to_atom(nil), do: nil
  defp maybe_to_atom(string) when is_binary(string), do: string |> String.to_atom()
end
