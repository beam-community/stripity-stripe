defmodule Stripe.FileUpload do
  @moduledoc """
  Work with Stripe file_upload objects.

  You can:

  - Create a file
  - Retrieve a file

  Stripe API reference: https://stripe.com/docs/api#file_uploads
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object, :created, :purpose, :size, :type, :metadata
  ]

  @relationships %{}

  @plural_endpoint "files"

  @doc """
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: map
  def relationships, do: @relationships

  @doc """
  Create a file according to Stripe's file_upload rules.

  Takes the filepath and the purpose.
  """
  @spec create(Path.t, String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(filepath, purpose, opts \\ []) do
    Stripe.Request.create_file_upload(@plural_endpoint, filepath, purpose, __MODULE__, opts)
  end

  @doc """
  Retrieve a file_upload.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve_file_upload(endpoint, __MODULE__, opts)
  end

end
