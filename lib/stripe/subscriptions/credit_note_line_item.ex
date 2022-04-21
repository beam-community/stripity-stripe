defmodule Stripe.CreditNoteLineItem do
  @moduledoc """
  Work with Stripe (credit note) line item objects.

  Note that these are distinct from invoice line item objects.

  Stripe API reference: https://stripe.com/docs/api/credit_notes/line_item
  """

  use Stripe.Entity
  import Stripe.Request

  @type tax_amount :: %{
          amount: integer,
          inclusive: boolean,
          tax_rate: Stripe.id() | Stripe.TaxRate.t()
        }

  @type discount :: %{
          amount: integer,
          discount: String.t(),
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          description: String.t(),
          discount_amount: integer,
          discount_amounts: [discount],
          invoice_line_item: Stripe.id() | nil,
          livemode: boolean,
          quantity: integer,
          tax_amounts: [tax_amount],
          tax_rates: [Stripe.TaxRate.t()],
          type: String.t(),
          unit_amount: integer | nil,
          unit_amount_decimal: String.t() | nil
        }

  defstruct [
    :id,
    :object,
    :amount,
    :description,
    :discount_amount,
    :discount_amounts,
    :invoice_line_item,
    :livemode,
    :quantity,
    :tax_amounts,
    :tax_rates,
    :type,
    :unit_amount,
    :unit_amount_decimal
  ]

  defp plural_endpoint(credit_note_id) do
    "credit_notes/#{credit_note_id}/lines"
  end

  @doc """
  Retrieve line items for a given credit note.
  """
  @spec retrieve(Stripe.id() | Stripe.CreditNote.t(), params, Stripe.options()) ::
          {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def retrieve(credit_note, params \\ %{}, opts \\ []) do
    plural_endpoint = credit_note |> get_id!() |> plural_endpoint()

    new_request(opts)
    |> put_endpoint(plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> make_request()
  end
end
