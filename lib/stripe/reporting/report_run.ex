defmodule Stripe.Reporting.ReportRun do
  @moduledoc """
  Work with Stripe Report Run objects.

  You can:

  - Create a report run
  - Retrieve a report run
  - List all report runs

  Stripe API reference: https://stripe.com/docs/api/reporting/report_run
  """

  use Stripe.Entity
  import Stripe.Request

  @typedoc """
  One of `"pending"`, `"succeeded"`, or `"failed"`.
  """
  @type status :: String.t()

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          parameters: map(),
          report_type: String.t(),
          result: map(),
          status: status(),
          created: Stripe.timestamp(),
          error: String.t(),
          livemode: boolean(),
          succeeded_at: Stripe.timestamp()
        }

  defstruct [
    :id,
    :object,
    :parameters,
    :report_type,
    :result,
    :status,
    :created,
    :error,
    :livemode,
    :succeeded_at
  ]

  @plural_endpoint "reporting/report_runs"

  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :report_type => String.t(),
                 optional(:parameters) => map()
               }
               | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:created) => Stripe.date_query(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end
