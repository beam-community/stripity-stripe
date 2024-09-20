defmodule Stripe.ApiErrors do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :charge,
      :code,
      :decline_code,
      :doc_url,
      :message,
      :param,
      :payment_intent,
      :payment_method,
      :payment_method_type,
      :request_log_url,
      :setup_intent,
      :source,
      :type
    ]

    @typedoc "The `api_errors` type.\n\n  * `charge` For card errors, the ID of the failed charge.\n  * `code` For some errors that could be handled programmatically, a short string indicating the [error code](https://stripe.com/docs/error-codes) reported.\n  * `decline_code` For card errors resulting from a card issuer decline, a short string indicating the [card issuer's reason for the decline](https://stripe.com/docs/declines#issuer-declines) if they provide one.\n  * `doc_url` A URL to more information about the [error code](https://stripe.com/docs/error-codes) reported.\n  * `message` A human-readable message providing more details about the error. For card errors, these messages can be shown to your users.\n  * `param` If the error is parameter-specific, the parameter related to the error. For example, you can use this to display a message near the correct form field.\n  * `payment_intent` \n  * `payment_method` \n  * `payment_method_type` If the error is specific to the type of payment method, the payment method type that had a problem. This field is only populated for invoice-related errors.\n  * `request_log_url` A URL to the request log entry in your dashboard.\n  * `setup_intent` \n  * `source` \n  * `type` The type of error returned. One of `api_error`, `card_error`, `idempotency_error`, or `invalid_request_error`\n"
    @type t :: %__MODULE__{
            charge: binary,
            code: binary,
            decline_code: binary,
            doc_url: binary,
            message: binary,
            param: binary,
            payment_intent: Stripe.PaymentIntent.t(),
            payment_method: Stripe.PaymentMethod.t(),
            payment_method_type: binary,
            request_log_url: binary,
            setup_intent: Stripe.SetupIntent.t(),
            source: Stripe.PaymentSource.t(),
            type: binary
          }
  )
end