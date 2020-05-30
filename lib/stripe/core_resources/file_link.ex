defmodule Stripe.FileLink do
  @moduledoc """
  Work with Stripe file_link objects.

  You can:

  - Create a file link
  - Retrieve a file link
  - Update a file link
  - List all file links

  Stripe API reference: https://stripe.com/docs/api/file_links
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          created: Stripe.timestamp(),
          expired: boolean,
          expires_at: Stripe.timestamp() | nil,
          file: Stripe.id() | Stripe.FileUpload.t() | nil,
          livemode: boolean,
          metadata: map,
          url: String.t() | nil
        }

  defstruct [
    :id,
    :object,
    :created,
    :expired,
    :expires_at,
    :file,
    :livemode,
    :metadata,
    :url
  ]

  @plural_endpoint "file_links"

  @doc """
  Create a file according to Stripe's file_upload rules.

  Takes a map with required 'file' field with FileUpload id or FileUpload
  struct, and optional 'expires_at' timestamp and optional 'metadata' map.
  """
  @spec create(params, Keyword.t()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               required(:file) => Stripe.id() | Stripe.FileUpload.t(),
               optional(:expires_at) => Stripe.timestamp(),
               optional(:metadata) => map
             }
  def create(params, opts \\ [])

  def create(%{file: %Stripe.FileUpload{id: file_id}} = params, opts) do
    params = %{params | file: file_id}
    create(params, opts)
  end

  def create(%{file: _} = params, opts) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Retrieve a file_link.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(file_link, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(file_link)}")
    |> put_method(:get)
    |> make_file_upload_request()
  end

  @doc """
  Update a file_link.

  Accepts params for 'expires_at' and 'metadata'. 
  The 'expires_at' param can be either a unix timestamp, or the string "now" to
  expire the link immediately.
  The 'metadata' on an existing file link can be unset by posting an empty map.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:expires_at) => String.t() | Stripe.timestamp(),
               optional(:metadata) => map
             }
  def update(file_link, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(file_link)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all file links.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:created) =>
                 Stripe.timestamp()
                 | %{
                     optional(:gt) => Stripe.timestamp(),
                     optional(:gte) => Stripe.timestamp(),
                     optional(:lt) => Stripe.timestamp(),
                     optional(:lte) => Stripe.timestamp()
                   },
               optional(:ending_before) => t | Stripe.id(),
               optional(:expired) => boolean,
               optional(:file) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after, :limit, :purpose])
    |> make_file_upload_request()
  end
end
