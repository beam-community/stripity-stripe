defmodule Stripe.Reporting.ReportType do
  @moduledoc """
  Work with Stripe Report Type objects.

  You can:

  - Retrieve a report type
  - List all report types

  Stripe API reference: https://stripe.com/docs/api/reporting/report_type
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          data_available_end: Stripe.timestamp(),
          data_available_start: Stripe.timestamp(),
          name: String.t(),
          default_columns: list(String.t()),
          livemode: boolean(),
          updated: Stripe.timestamp(),
          version: integer()
        }

  defstruct [
    :id,
    :object,
    :data_available_end,
    :data_available_start,
    :name,
    :default_columns,
    :livemode,
    :updated,
    :version
  ]

  @plural_endpoint "reporting/report_types"

  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @spec list(Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
  def list(opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> make_request()
  end
end
