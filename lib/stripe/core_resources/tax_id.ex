defmodule Stripe.TaxID do
  @moduledoc """
  You can add one or multiple tax IDs to a customer. A customer's tax IDs are
  displayed on invoices and credit notes issued for the customer.

  See [Stripe Tax IDs docs](https://stripe.com/docs/api/customer_tax_ids)
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          created: Stripe.timestamp(),
          country: String.t(),
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          livemode: boolean,
          type: String.t(),
          value: String.t(),
          verification: tax_info_verification | nil
        }

  @type tax_info_verification :: %{
          status: String.t() | nil,
          verified_name: String.t() | nil,
          verified_address: String.t() | nil
        }

  @type tax_id_data :: %{
          type: String.t(),
          value: String.t()
        }

  defstruct [
    :id,
    :object,
    :created,
    :country,
    :customer,
    :livemode,
    :type,
    :value,
    :verification
  ]

  defp plural_endpoint(%{customer: id}) do
    "customers/" <> id <> "/tax_ids"
  end

  @doc """
  Creates a new `TaxID` object for a customer.

  ### Example

      Stripe.TaxId.create(%{customer: "cus_FDVoXj36NmFrao", type: "eu_vat", value: "DE123456789"})

      Stripe.TaxId.create(%{customer: %Stripe.Customer{id: "cus_FDVoXj36NmFrao"}, type: "eu_vat", value: "DE123456789"})

  See [Stripe docs](https://stripe.com/docs/api/customer_tax_ids/create)
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :customer => Stripe.id(),
                 :type => String.t(),
                 :value => String.t()
               }
               | %{}
  def create(params, opts \\ []) do
    updated_params =
      params
      |> Map.delete(:customer)

    new_request(opts)
    |> put_endpoint(plural_endpoint(params))
    |> put_method(:post)
    |> put_params(updated_params)
    |> make_request()
  end

  @doc """
  Retrieves the `TaxID` object with the given identifier.

  ### Example

      Stripe.TaxId.retrieve("txi_123456789", %{customer: "cus_FDVoXj36NmFrao")})

      Stripe.TaxId.retrieve("txi_123456789", %{customer: %Stripe.Customer{id: "cus_FDVoXj36NmFrao"}})

  See [Stripe docs](https://stripe.com/docs/api/customer_tax_ids/retrieve)
  """
  @spec retrieve(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, %{customer: _} = params, opts \\ []) do
    endpoint = params |> plural_endpoint()

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Deletes an existing `TaxID` object.

  ### Example

      Stripe.TaxId.delete("txi_123456789", %{customer: "cus_FDVoXj36NmFrao")})

      Stripe.TaxId.delete("txi_123456789", %{customer: %Stripe.Customer{id: "cus_FDVoXj36NmFrao"}})

      Stripe.TaxId.delete(%Stripe.TaxID{id: "txi_123456789"}, %{customer: "cus_FDVoXj36NmFrao"})

  See [Stripe docs](https://stripe.com/docs/api/customer_tax_ids/delete)
  """
  @spec delete(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, %{customer: _} = params, opts \\ []) do
    endpoint = plural_endpoint(params)

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  Returns a list of tax IDs for a customer.

  ### Example

      Stripe.TaxId.list(%{customer: "cus_FDVoXj36NmFrao")})

  See [Stripe docs](https://stripe.com/docs/api/customer_tax_ids/list)
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               :customer => Stripe.id() | Stripe.Customer.t(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(%{customer: _} = params, opts \\ []) do
    updated_params =
      params
      |> Map.delete(:customer)

    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(plural_endpoint(params))
    |> put_method(:get)
    |> put_params(updated_params)
    |> cast_to_id([:customer, :ending_before, :starting_after])
    |> make_request()
  end
end
