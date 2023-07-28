defmodule Stripe.DeletedDiscount do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :checkout_session,
      :coupon,
      :customer,
      :deleted,
      :id,
      :invoice,
      :invoice_item,
      :object,
      :promotion_code,
      :start,
      :subscription
    ]

    @typedoc "The `deleted_discount` type.\n\n  * `checkout_session` The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Will not be present for subscription mode.\n  * `coupon` \n  * `customer` The ID of the customer associated with this discount.\n  * `deleted` Always true for a deleted object\n  * `id` The ID of the discount object. Discounts cannot be fetched by ID. Use `expand[]=discounts` in API calls to expand discount IDs in an array.\n  * `invoice` The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice.\n  * `invoice_item` The invoice item `id` (or invoice line item `id` for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `promotion_code` The promotion code applied to create this discount.\n  * `start` Date that the coupon was applied.\n  * `subscription` The subscription that this coupon is applied to, if it is applied to a particular subscription.\n"
    @type t :: %__MODULE__{
            checkout_session: binary | nil,
            coupon: Stripe.Coupon.t(),
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            deleted: boolean,
            id: binary,
            invoice: binary | nil,
            invoice_item: binary | nil,
            object: binary,
            promotion_code: (binary | Stripe.PromotionCode.t()) | nil,
            start: integer,
            subscription: binary | nil
          }
  )
end