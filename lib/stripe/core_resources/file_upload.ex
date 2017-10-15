defmodule Stripe.FileUpload do
  @moduledoc """
  Work with Stripe file_upload objects.

  You can:

  - Create a file
  - Retrieve a file

  Stripe API reference: https://stripe.com/docs/api#file_uploads
  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               created: Stripe.timestamp,
               purpose: :dispute_evidence | :identity_document | :business_logo,
               size: integer,
               type: :pdf | :jpg | :png,
               url: String.t
             }

  defstruct [
    :id,
    :object,
    :created,
    :purpose,
    :size,
    :type,
    :url
  ]

  @plural_endpoint "files"

  @doc """
  Create a file according to Stripe's file_upload rules.

  Takes the filepath and the purpose.
  """
  @spec create(Path.t, String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(filepath, purpose, opts \\ []) do
    Stripe.Request.create_file_upload(@plural_endpoint, filepath, purpose, opts)
  end

  @doc """
  Retrieve a file_upload.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve_file_upload(endpoint, opts)
  end

  @doc """
  List all file uploads.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end
