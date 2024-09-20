defmodule Stripe.Treasury.FinancialAccountFeatures do
  use Stripe.Entity

  @moduledoc "Encodes whether a FinancialAccount has access to a particular Feature, with a `status` enum and associated `status_details`.\nStripe or the platform can control Features via the requested field."
  (
    defstruct [
      :card_issuing,
      :deposit_insurance,
      :financial_addresses,
      :inbound_transfers,
      :intra_stripe_flows,
      :object,
      :outbound_payments,
      :outbound_transfers
    ]

    @typedoc "The `treasury.financial_account_features` type.\n\n  * `card_issuing` \n  * `deposit_insurance` \n  * `financial_addresses` \n  * `inbound_transfers` \n  * `intra_stripe_flows` \n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `outbound_payments` \n  * `outbound_transfers` \n"
    @type t :: %__MODULE__{
            card_issuing: term,
            deposit_insurance: term,
            financial_addresses: term,
            inbound_transfers: term,
            intra_stripe_flows: term,
            object: binary,
            outbound_payments: term,
            outbound_transfers: term
          }
  )
end
