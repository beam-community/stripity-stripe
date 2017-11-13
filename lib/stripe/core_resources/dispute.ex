defmodule Stripe.Dispute do
  @moduledoc """
  Work with Stripe disputes.

  Stripe API reference: https://stripe.com/docs/api#disputes
  """
  use Stripe.Entity

  @type dispute_evidence :: %{
                              access_activity_log: String.t,
                              billing_address: String.t,
                              cancellation_policy: Stripe.id | Stripe.FileUpload.t,
                              cancellation_policy_disclosure: String.t,
                              cancellation_rebuttal: String.t,
                              customer_communication: Stripe.id | Stripe.FileUpload.t,
                              customer_email_address: String.t,
                              customer_name: String.t,
                              customer_purchase_ip: String.t,
                              customer_signature: Stripe.id | Stripe.FileUpload.t,
                              duplicate_charge_documentation: Stripe.id | Stripe.FileUpload.t,
                              duplicate_charge_explanation: String.t,
                              duplicate_charge_id: Stripe.id,
                              product_description: String.t,
                              receipt: Stripe.id | Stripe.FileUpload.t,
                              refund_policy: Stripe.id | Stripe.FileUpload.t,
                              refund_policy_disclosure: String.t,
                              refund_refusal_explanation: String.t,
                              service_date: String.t,
                              service_documentation: Stripe.id | Stripe.FileUpload.t,
                              shipping_address: String.t,
                              shipping_carrier: String.t,
                              shipping_date: String.t,
                              shipping_documentation: Stripe.id | Stripe.FileUpload.t,
                              shipping_tracking_number: Stripe.id | Stripe.FileUpload.t,
                              uncategorized_file: Stripe.id | Stripe.FileUpload.t,
                              uncategorized_text: String.t
                            }

  @type evidence_details :: %{
                              due_by: Stripe.timestamp,
                              has_evidence: boolean,
                              past_due: boolean,
                              submission_count: integer
                            }

  @type dispute_reason :: :duplicate | :fraudulent | :subscription_canceled |
                          :product_unacceptable | :product_not_received |
                          :unrecognized | :credit_not_processed | :general |
                          :incorrect_account_details | :insufficient_funds |
                          :bank_cannot_process | :debit_not_authorized |
                          :customer_initiated

  @type dispute_status :: :warning_needs_response | :warning_under_review |
                          :warning_closed | :needs_response | :under_review |
                          :charge_refunded | :won | :lost

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount: integer,
               balance_transactions: [Stripe.BalanceTransaction.t],
               charge: Stripe.id | Stripe.Charge.t,
               created: Stripe.timestamp,
               currency: String.t,
               evidence: dispute_evidence,
               evidence_details: evidence_details,
               is_charge_refundable: boolean,
               livemode: boolean,
               metadata: %{
                 optional(String.t) => String.t
               },
               reason: dispute_reason,
               status: dispute_status
             }

  defstruct [
    :id,
    :object,
    :amount,
    :balance_transactions,
    :charge,
    :created,
    :currency,
    :evidence,
    :evidence_details,
    :is_charge_refundable,
    :livemode,
    :metadata,
    :reason,
    :status
  ]
end
