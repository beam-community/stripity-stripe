defmodule Stripe.Discount do
  use Stripe.Entity

  @moduledoc "A discount represents the actual application of a [coupon](https://stripe.com/docs/api#coupons) or [promotion code](https://stripe.com/docs/api#promotion_codes).\nIt contains information about when the discount began, when it will end, and what it is applied to.\n\nRelated guide: [Applying discounts to subscriptions](https://stripe.com/docs/billing/subscriptions/discounts)"
  (
    defstruct [
      :checkout_session,
      :customer,
      :end,
      :id,
      :invoice,
      :invoice_item,
      :object,
      :promotion_code,
      :source,
      :start,
      :subscription,
      :subscription_item
    ]

    @typedoc "The `discount` type.\n\n  * `checkout_session` The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Will not be present for subscription mode.\n  * `customer` The ID of the customer associated with this discount.\n  * `end` If the coupon has a duration of `repeating`, the date that this discount will end. If the coupon has a duration of `once` or `forever`, this attribute will be null.\n  * `id` The ID of the discount object. Discounts cannot be fetched by ID. Use `expand[]=discounts` in API calls to expand discount IDs in an array.\n  * `invoice` The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice.\n  * `invoice_item` The invoice item `id` (or invoice line item `id` for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `promotion_code` The promotion code applied to create this discount.\n  * `source` \n  * `start` Date that the coupon was applied.\n  * `subscription` The subscription that this coupon is applied to, if it is applied to a particular subscription.\n  * `subscription_item` The subscription item that this coupon is applied to, if it is applied to a particular subscription item.\n"
    @type t :: %__MODULE__{
            checkout_session: binary | nil,
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            end: integer | nil,
            id: binary,
            invoice: binary | nil,
            invoice_item: binary | nil,
            object: binary,
            promotion_code: (binary | Stripe.PromotionCode.t()) | nil,
            source: term,
            start: integer,
            subscription: binary | nil,
            subscription_item: binary | nil
          }
  )
end