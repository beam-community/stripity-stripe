defmodule Stripe.WebhookEndpoint do
  use Stripe.Entity

  @moduledoc "You can configure [webhook endpoints](https://stripe.com/docs/webhooks/) via the API to be\nnotified about events that happen in your Stripe account or connected\naccounts.\n\nMost users configure webhooks from [the dashboard](https://dashboard.stripe.com/webhooks), which provides a user interface for registering and testing your webhook endpoints.\n\nRelated guide: [Setting up webhooks](https://stripe.com/docs/webhooks/configure)"
  (
    defstruct [
      :api_version,
      :application,
      :created,
      :description,
      :enabled_events,
      :id,
      :livemode,
      :metadata,
      :object,
      :secret,
      :status,
      :url
    ]

    @typedoc "The `webhook_endpoint` type.\n\n  * `api_version` The API version events are rendered as for this webhook endpoint.\n  * `application` The ID of the associated Connect application.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `description` An optional description of what the webhook is used for.\n  * `enabled_events` The list of events to enable for this endpoint. `['*']` indicates that all events are enabled, except those that require explicit selection.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `secret` The endpoint's secret, used to generate [webhook signatures](https://stripe.com/docs/webhooks/signatures). Only returned at creation.\n  * `status` The status of the webhook. It can be `enabled` or `disabled`.\n  * `url` The URL of the webhook endpoint.\n"
    @type t :: %__MODULE__{
            api_version: binary | nil,
            application: binary | nil,
            created: integer,
            description: binary | nil,
            enabled_events: term,
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
            secret: binary,
            status: binary,
            url: binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of your webhook endpoints.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/webhook_endpoints`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.WebhookEndpoint.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/webhook_endpoints", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Retrieves the webhook endpoint with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/webhook_endpoints/{webhook_endpoint}`\n"
    (
      @spec retrieve(
              webhook_endpoint :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.WebhookEndpoint.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(webhook_endpoint, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/webhook_endpoints/{webhook_endpoint}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "webhook_endpoint",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "webhook_endpoint",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [webhook_endpoint]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>A webhook endpoint must have a <code>url</code> and a list of <code>enabled_events</code>. You may optionally specify the Boolean <code>connect</code> parameter. If set to true, then a Connect webhook endpoint that notifies the specified <code>url</code> about events from all connected accounts is created; otherwise an account webhook endpoint that notifies the specified <code>url</code> only about events from your account is created. You can also create webhook endpoints in the <a href=\"https://dashboard.stripe.com/account/webhooks\">webhooks settings</a> section of the Dashboard.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/webhook_endpoints`\n"
    (
      @spec create(
              params :: %{
                optional(:api_version) =>
                  :"2011-01-01"
                  | :"2011-06-21"
                  | :"2011-06-28"
                  | :"2011-08-01"
                  | :"2011-09-15"
                  | :"2011-11-17"
                  | :"2012-02-23"
                  | :"2012-03-25"
                  | :"2012-06-18"
                  | :"2012-06-28"
                  | :"2012-07-09"
                  | :"2012-09-24"
                  | :"2012-10-26"
                  | :"2012-11-07"
                  | :"2013-02-11"
                  | :"2013-02-13"
                  | :"2013-07-05"
                  | :"2013-08-12"
                  | :"2013-08-13"
                  | :"2013-10-29"
                  | :"2013-12-03"
                  | :"2014-01-31"
                  | :"2014-03-13"
                  | :"2014-03-28"
                  | :"2014-05-19"
                  | :"2014-06-13"
                  | :"2014-06-17"
                  | :"2014-07-22"
                  | :"2014-07-26"
                  | :"2014-08-04"
                  | :"2014-08-20"
                  | :"2014-09-08"
                  | :"2014-10-07"
                  | :"2014-11-05"
                  | :"2014-11-20"
                  | :"2014-12-08"
                  | :"2014-12-17"
                  | :"2014-12-22"
                  | :"2015-01-11"
                  | :"2015-01-26"
                  | :"2015-02-10"
                  | :"2015-02-16"
                  | :"2015-02-18"
                  | :"2015-03-24"
                  | :"2015-04-07"
                  | :"2015-06-15"
                  | :"2015-07-07"
                  | :"2015-07-13"
                  | :"2015-07-28"
                  | :"2015-08-07"
                  | :"2015-08-19"
                  | :"2015-09-03"
                  | :"2015-09-08"
                  | :"2015-09-23"
                  | :"2015-10-01"
                  | :"2015-10-12"
                  | :"2015-10-16"
                  | :"2016-02-03"
                  | :"2016-02-19"
                  | :"2016-02-22"
                  | :"2016-02-23"
                  | :"2016-02-29"
                  | :"2016-03-07"
                  | :"2016-06-15"
                  | :"2016-07-06"
                  | :"2016-10-19"
                  | :"2017-01-27"
                  | :"2017-02-14"
                  | :"2017-04-06"
                  | :"2017-05-25"
                  | :"2017-06-05"
                  | :"2017-08-15"
                  | :"2017-12-14"
                  | :"2018-01-23"
                  | :"2018-02-05"
                  | :"2018-02-06"
                  | :"2018-02-28"
                  | :"2018-05-21"
                  | :"2018-07-27"
                  | :"2018-08-23"
                  | :"2018-09-06"
                  | :"2018-09-24"
                  | :"2018-10-31"
                  | :"2018-11-08"
                  | :"2019-02-11"
                  | :"2019-02-19"
                  | :"2019-03-14"
                  | :"2019-05-16"
                  | :"2019-08-14"
                  | :"2019-09-09"
                  | :"2019-10-08"
                  | :"2019-10-17"
                  | :"2019-11-05"
                  | :"2019-12-03"
                  | :"2020-03-02"
                  | :"2020-08-27"
                  | :"2022-08-01"
                  | :"2022-11-15"
                  | :"2023-08-16"
                  | :"2023-10-16",
                optional(:connect) => boolean,
                optional(:description) => binary | binary,
                optional(:enabled_events) =>
                  list(
                    :*
                    | :"account.application.authorized"
                    | :"account.application.deauthorized"
                    | :"account.external_account.created"
                    | :"account.external_account.deleted"
                    | :"account.external_account.updated"
                    | :"account.updated"
                    | :"application_fee.created"
                    | :"application_fee.refund.updated"
                    | :"application_fee.refunded"
                    | :"balance.available"
                    | :"billing_portal.configuration.created"
                    | :"billing_portal.configuration.updated"
                    | :"billing_portal.session.created"
                    | :"capability.updated"
                    | :"cash_balance.funds_available"
                    | :"charge.captured"
                    | :"charge.dispute.closed"
                    | :"charge.dispute.created"
                    | :"charge.dispute.funds_reinstated"
                    | :"charge.dispute.funds_withdrawn"
                    | :"charge.dispute.updated"
                    | :"charge.expired"
                    | :"charge.failed"
                    | :"charge.pending"
                    | :"charge.refund.updated"
                    | :"charge.refunded"
                    | :"charge.succeeded"
                    | :"charge.updated"
                    | :"checkout.session.async_payment_failed"
                    | :"checkout.session.async_payment_succeeded"
                    | :"checkout.session.completed"
                    | :"checkout.session.expired"
                    | :"climate.order.canceled"
                    | :"climate.order.created"
                    | :"climate.order.delayed"
                    | :"climate.order.delivered"
                    | :"climate.order.product_substituted"
                    | :"climate.product.created"
                    | :"climate.product.pricing_updated"
                    | :"coupon.created"
                    | :"coupon.deleted"
                    | :"coupon.updated"
                    | :"credit_note.created"
                    | :"credit_note.updated"
                    | :"credit_note.voided"
                    | :"customer.created"
                    | :"customer.deleted"
                    | :"customer.discount.created"
                    | :"customer.discount.deleted"
                    | :"customer.discount.updated"
                    | :"customer.source.created"
                    | :"customer.source.deleted"
                    | :"customer.source.expiring"
                    | :"customer.source.updated"
                    | :"customer.subscription.created"
                    | :"customer.subscription.deleted"
                    | :"customer.subscription.paused"
                    | :"customer.subscription.pending_update_applied"
                    | :"customer.subscription.pending_update_expired"
                    | :"customer.subscription.resumed"
                    | :"customer.subscription.trial_will_end"
                    | :"customer.subscription.updated"
                    | :"customer.tax_id.created"
                    | :"customer.tax_id.deleted"
                    | :"customer.tax_id.updated"
                    | :"customer.updated"
                    | :"customer_cash_balance_transaction.created"
                    | :"file.created"
                    | :"financial_connections.account.created"
                    | :"financial_connections.account.deactivated"
                    | :"financial_connections.account.disconnected"
                    | :"financial_connections.account.reactivated"
                    | :"financial_connections.account.refreshed_balance"
                    | :"financial_connections.account.refreshed_transactions"
                    | :"identity.verification_session.canceled"
                    | :"identity.verification_session.created"
                    | :"identity.verification_session.processing"
                    | :"identity.verification_session.redacted"
                    | :"identity.verification_session.requires_input"
                    | :"identity.verification_session.verified"
                    | :"invoice.created"
                    | :"invoice.deleted"
                    | :"invoice.finalization_failed"
                    | :"invoice.finalized"
                    | :"invoice.marked_uncollectible"
                    | :"invoice.paid"
                    | :"invoice.payment_action_required"
                    | :"invoice.payment_failed"
                    | :"invoice.payment_succeeded"
                    | :"invoice.sent"
                    | :"invoice.upcoming"
                    | :"invoice.updated"
                    | :"invoice.voided"
                    | :"invoiceitem.created"
                    | :"invoiceitem.deleted"
                    | :"issuing_authorization.created"
                    | :"issuing_authorization.request"
                    | :"issuing_authorization.updated"
                    | :"issuing_card.created"
                    | :"issuing_card.updated"
                    | :"issuing_cardholder.created"
                    | :"issuing_cardholder.updated"
                    | :"issuing_dispute.closed"
                    | :"issuing_dispute.created"
                    | :"issuing_dispute.funds_reinstated"
                    | :"issuing_dispute.submitted"
                    | :"issuing_dispute.updated"
                    | :"issuing_token.created"
                    | :"issuing_token.updated"
                    | :"issuing_transaction.created"
                    | :"issuing_transaction.updated"
                    | :"mandate.updated"
                    | :"payment_intent.amount_capturable_updated"
                    | :"payment_intent.canceled"
                    | :"payment_intent.created"
                    | :"payment_intent.partially_funded"
                    | :"payment_intent.payment_failed"
                    | :"payment_intent.processing"
                    | :"payment_intent.requires_action"
                    | :"payment_intent.succeeded"
                    | :"payment_link.created"
                    | :"payment_link.updated"
                    | :"payment_method.attached"
                    | :"payment_method.automatically_updated"
                    | :"payment_method.detached"
                    | :"payment_method.updated"
                    | :"payout.canceled"
                    | :"payout.created"
                    | :"payout.failed"
                    | :"payout.paid"
                    | :"payout.reconciliation_completed"
                    | :"payout.updated"
                    | :"person.created"
                    | :"person.deleted"
                    | :"person.updated"
                    | :"plan.created"
                    | :"plan.deleted"
                    | :"plan.updated"
                    | :"price.created"
                    | :"price.deleted"
                    | :"price.updated"
                    | :"product.created"
                    | :"product.deleted"
                    | :"product.updated"
                    | :"promotion_code.created"
                    | :"promotion_code.updated"
                    | :"quote.accepted"
                    | :"quote.canceled"
                    | :"quote.created"
                    | :"quote.finalized"
                    | :"radar.early_fraud_warning.created"
                    | :"radar.early_fraud_warning.updated"
                    | :"refund.created"
                    | :"refund.updated"
                    | :"reporting.report_run.failed"
                    | :"reporting.report_run.succeeded"
                    | :"reporting.report_type.updated"
                    | :"review.closed"
                    | :"review.opened"
                    | :"setup_intent.canceled"
                    | :"setup_intent.created"
                    | :"setup_intent.requires_action"
                    | :"setup_intent.setup_failed"
                    | :"setup_intent.succeeded"
                    | :"sigma.scheduled_query_run.created"
                    | :"source.canceled"
                    | :"source.chargeable"
                    | :"source.failed"
                    | :"source.mandate_notification"
                    | :"source.refund_attributes_required"
                    | :"source.transaction.created"
                    | :"source.transaction.updated"
                    | :"subscription_schedule.aborted"
                    | :"subscription_schedule.canceled"
                    | :"subscription_schedule.completed"
                    | :"subscription_schedule.created"
                    | :"subscription_schedule.expiring"
                    | :"subscription_schedule.released"
                    | :"subscription_schedule.updated"
                    | :"tax.settings.updated"
                    | :"tax_rate.created"
                    | :"tax_rate.updated"
                    | :"terminal.reader.action_failed"
                    | :"terminal.reader.action_succeeded"
                    | :"test_helpers.test_clock.advancing"
                    | :"test_helpers.test_clock.created"
                    | :"test_helpers.test_clock.deleted"
                    | :"test_helpers.test_clock.internal_failure"
                    | :"test_helpers.test_clock.ready"
                    | :"topup.canceled"
                    | :"topup.created"
                    | :"topup.failed"
                    | :"topup.reversed"
                    | :"topup.succeeded"
                    | :"transfer.created"
                    | :"transfer.reversed"
                    | :"transfer.updated"
                    | :"treasury.credit_reversal.created"
                    | :"treasury.credit_reversal.posted"
                    | :"treasury.debit_reversal.completed"
                    | :"treasury.debit_reversal.created"
                    | :"treasury.debit_reversal.initial_credit_granted"
                    | :"treasury.financial_account.closed"
                    | :"treasury.financial_account.created"
                    | :"treasury.financial_account.features_status_updated"
                    | :"treasury.inbound_transfer.canceled"
                    | :"treasury.inbound_transfer.created"
                    | :"treasury.inbound_transfer.failed"
                    | :"treasury.inbound_transfer.succeeded"
                    | :"treasury.outbound_payment.canceled"
                    | :"treasury.outbound_payment.created"
                    | :"treasury.outbound_payment.expected_arrival_date_updated"
                    | :"treasury.outbound_payment.failed"
                    | :"treasury.outbound_payment.posted"
                    | :"treasury.outbound_payment.returned"
                    | :"treasury.outbound_transfer.canceled"
                    | :"treasury.outbound_transfer.created"
                    | :"treasury.outbound_transfer.expected_arrival_date_updated"
                    | :"treasury.outbound_transfer.failed"
                    | :"treasury.outbound_transfer.posted"
                    | :"treasury.outbound_transfer.returned"
                    | :"treasury.received_credit.created"
                    | :"treasury.received_credit.failed"
                    | :"treasury.received_credit.succeeded"
                    | :"treasury.received_debit.created"
                  ),
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:url) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.WebhookEndpoint.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/webhook_endpoints", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Updates the webhook endpoint. You may edit the <code>url</code>, the list of <code>enabled_events</code>, and the status of your endpoint.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/webhook_endpoints/{webhook_endpoint}`\n"
    (
      @spec update(
              webhook_endpoint :: binary(),
              params :: %{
                optional(:description) => binary | binary,
                optional(:disabled) => boolean,
                optional(:enabled_events) =>
                  list(
                    :*
                    | :"account.application.authorized"
                    | :"account.application.deauthorized"
                    | :"account.external_account.created"
                    | :"account.external_account.deleted"
                    | :"account.external_account.updated"
                    | :"account.updated"
                    | :"application_fee.created"
                    | :"application_fee.refund.updated"
                    | :"application_fee.refunded"
                    | :"balance.available"
                    | :"billing_portal.configuration.created"
                    | :"billing_portal.configuration.updated"
                    | :"billing_portal.session.created"
                    | :"capability.updated"
                    | :"cash_balance.funds_available"
                    | :"charge.captured"
                    | :"charge.dispute.closed"
                    | :"charge.dispute.created"
                    | :"charge.dispute.funds_reinstated"
                    | :"charge.dispute.funds_withdrawn"
                    | :"charge.dispute.updated"
                    | :"charge.expired"
                    | :"charge.failed"
                    | :"charge.pending"
                    | :"charge.refund.updated"
                    | :"charge.refunded"
                    | :"charge.succeeded"
                    | :"charge.updated"
                    | :"checkout.session.async_payment_failed"
                    | :"checkout.session.async_payment_succeeded"
                    | :"checkout.session.completed"
                    | :"checkout.session.expired"
                    | :"climate.order.canceled"
                    | :"climate.order.created"
                    | :"climate.order.delayed"
                    | :"climate.order.delivered"
                    | :"climate.order.product_substituted"
                    | :"climate.product.created"
                    | :"climate.product.pricing_updated"
                    | :"coupon.created"
                    | :"coupon.deleted"
                    | :"coupon.updated"
                    | :"credit_note.created"
                    | :"credit_note.updated"
                    | :"credit_note.voided"
                    | :"customer.created"
                    | :"customer.deleted"
                    | :"customer.discount.created"
                    | :"customer.discount.deleted"
                    | :"customer.discount.updated"
                    | :"customer.source.created"
                    | :"customer.source.deleted"
                    | :"customer.source.expiring"
                    | :"customer.source.updated"
                    | :"customer.subscription.created"
                    | :"customer.subscription.deleted"
                    | :"customer.subscription.paused"
                    | :"customer.subscription.pending_update_applied"
                    | :"customer.subscription.pending_update_expired"
                    | :"customer.subscription.resumed"
                    | :"customer.subscription.trial_will_end"
                    | :"customer.subscription.updated"
                    | :"customer.tax_id.created"
                    | :"customer.tax_id.deleted"
                    | :"customer.tax_id.updated"
                    | :"customer.updated"
                    | :"customer_cash_balance_transaction.created"
                    | :"file.created"
                    | :"financial_connections.account.created"
                    | :"financial_connections.account.deactivated"
                    | :"financial_connections.account.disconnected"
                    | :"financial_connections.account.reactivated"
                    | :"financial_connections.account.refreshed_balance"
                    | :"financial_connections.account.refreshed_transactions"
                    | :"identity.verification_session.canceled"
                    | :"identity.verification_session.created"
                    | :"identity.verification_session.processing"
                    | :"identity.verification_session.redacted"
                    | :"identity.verification_session.requires_input"
                    | :"identity.verification_session.verified"
                    | :"invoice.created"
                    | :"invoice.deleted"
                    | :"invoice.finalization_failed"
                    | :"invoice.finalized"
                    | :"invoice.marked_uncollectible"
                    | :"invoice.paid"
                    | :"invoice.payment_action_required"
                    | :"invoice.payment_failed"
                    | :"invoice.payment_succeeded"
                    | :"invoice.sent"
                    | :"invoice.upcoming"
                    | :"invoice.updated"
                    | :"invoice.voided"
                    | :"invoiceitem.created"
                    | :"invoiceitem.deleted"
                    | :"issuing_authorization.created"
                    | :"issuing_authorization.request"
                    | :"issuing_authorization.updated"
                    | :"issuing_card.created"
                    | :"issuing_card.updated"
                    | :"issuing_cardholder.created"
                    | :"issuing_cardholder.updated"
                    | :"issuing_dispute.closed"
                    | :"issuing_dispute.created"
                    | :"issuing_dispute.funds_reinstated"
                    | :"issuing_dispute.submitted"
                    | :"issuing_dispute.updated"
                    | :"issuing_token.created"
                    | :"issuing_token.updated"
                    | :"issuing_transaction.created"
                    | :"issuing_transaction.updated"
                    | :"mandate.updated"
                    | :"payment_intent.amount_capturable_updated"
                    | :"payment_intent.canceled"
                    | :"payment_intent.created"
                    | :"payment_intent.partially_funded"
                    | :"payment_intent.payment_failed"
                    | :"payment_intent.processing"
                    | :"payment_intent.requires_action"
                    | :"payment_intent.succeeded"
                    | :"payment_link.created"
                    | :"payment_link.updated"
                    | :"payment_method.attached"
                    | :"payment_method.automatically_updated"
                    | :"payment_method.detached"
                    | :"payment_method.updated"
                    | :"payout.canceled"
                    | :"payout.created"
                    | :"payout.failed"
                    | :"payout.paid"
                    | :"payout.reconciliation_completed"
                    | :"payout.updated"
                    | :"person.created"
                    | :"person.deleted"
                    | :"person.updated"
                    | :"plan.created"
                    | :"plan.deleted"
                    | :"plan.updated"
                    | :"price.created"
                    | :"price.deleted"
                    | :"price.updated"
                    | :"product.created"
                    | :"product.deleted"
                    | :"product.updated"
                    | :"promotion_code.created"
                    | :"promotion_code.updated"
                    | :"quote.accepted"
                    | :"quote.canceled"
                    | :"quote.created"
                    | :"quote.finalized"
                    | :"radar.early_fraud_warning.created"
                    | :"radar.early_fraud_warning.updated"
                    | :"refund.created"
                    | :"refund.updated"
                    | :"reporting.report_run.failed"
                    | :"reporting.report_run.succeeded"
                    | :"reporting.report_type.updated"
                    | :"review.closed"
                    | :"review.opened"
                    | :"setup_intent.canceled"
                    | :"setup_intent.created"
                    | :"setup_intent.requires_action"
                    | :"setup_intent.setup_failed"
                    | :"setup_intent.succeeded"
                    | :"sigma.scheduled_query_run.created"
                    | :"source.canceled"
                    | :"source.chargeable"
                    | :"source.failed"
                    | :"source.mandate_notification"
                    | :"source.refund_attributes_required"
                    | :"source.transaction.created"
                    | :"source.transaction.updated"
                    | :"subscription_schedule.aborted"
                    | :"subscription_schedule.canceled"
                    | :"subscription_schedule.completed"
                    | :"subscription_schedule.created"
                    | :"subscription_schedule.expiring"
                    | :"subscription_schedule.released"
                    | :"subscription_schedule.updated"
                    | :"tax.settings.updated"
                    | :"tax_rate.created"
                    | :"tax_rate.updated"
                    | :"terminal.reader.action_failed"
                    | :"terminal.reader.action_succeeded"
                    | :"test_helpers.test_clock.advancing"
                    | :"test_helpers.test_clock.created"
                    | :"test_helpers.test_clock.deleted"
                    | :"test_helpers.test_clock.internal_failure"
                    | :"test_helpers.test_clock.ready"
                    | :"topup.canceled"
                    | :"topup.created"
                    | :"topup.failed"
                    | :"topup.reversed"
                    | :"topup.succeeded"
                    | :"transfer.created"
                    | :"transfer.reversed"
                    | :"transfer.updated"
                    | :"treasury.credit_reversal.created"
                    | :"treasury.credit_reversal.posted"
                    | :"treasury.debit_reversal.completed"
                    | :"treasury.debit_reversal.created"
                    | :"treasury.debit_reversal.initial_credit_granted"
                    | :"treasury.financial_account.closed"
                    | :"treasury.financial_account.created"
                    | :"treasury.financial_account.features_status_updated"
                    | :"treasury.inbound_transfer.canceled"
                    | :"treasury.inbound_transfer.created"
                    | :"treasury.inbound_transfer.failed"
                    | :"treasury.inbound_transfer.succeeded"
                    | :"treasury.outbound_payment.canceled"
                    | :"treasury.outbound_payment.created"
                    | :"treasury.outbound_payment.expected_arrival_date_updated"
                    | :"treasury.outbound_payment.failed"
                    | :"treasury.outbound_payment.posted"
                    | :"treasury.outbound_payment.returned"
                    | :"treasury.outbound_transfer.canceled"
                    | :"treasury.outbound_transfer.created"
                    | :"treasury.outbound_transfer.expected_arrival_date_updated"
                    | :"treasury.outbound_transfer.failed"
                    | :"treasury.outbound_transfer.posted"
                    | :"treasury.outbound_transfer.returned"
                    | :"treasury.received_credit.created"
                    | :"treasury.received_credit.failed"
                    | :"treasury.received_credit.succeeded"
                    | :"treasury.received_debit.created"
                  ),
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:url) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.WebhookEndpoint.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(webhook_endpoint, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/webhook_endpoints/{webhook_endpoint}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "webhook_endpoint",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "webhook_endpoint",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [webhook_endpoint]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>You can also delete webhook endpoints via the <a href=\"https://dashboard.stripe.com/account/webhooks\">webhook endpoint management</a> page of the Stripe dashboard.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/webhook_endpoints/{webhook_endpoint}`\n"
    (
      @spec delete(webhook_endpoint :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedWebhookEndpoint.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(webhook_endpoint, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/webhook_endpoints/{webhook_endpoint}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "webhook_endpoint",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "webhook_endpoint",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [webhook_endpoint]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end
