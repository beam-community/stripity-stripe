defmodule Stripe.File do
  use Stripe.Entity

  @moduledoc "This object represents files hosted on Stripe's servers. You can upload\nfiles with the [create file](https://stripe.com/docs/api#create_file) request\n(for example, when uploading dispute evidence). Stripe also\ncreates files independently (for example, the results of a [Sigma scheduled\nquery](#scheduled_queries)).\n\nRelated guide: [File upload guide](https://stripe.com/docs/file-upload)"
  (
    defstruct [
      :created,
      :expires_at,
      :filename,
      :id,
      :links,
      :object,
      :purpose,
      :size,
      :title,
      :type,
      :url
    ]

    @typedoc "The `file` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `expires_at` The file expires and isn't available at this time in epoch seconds.\n  * `filename` The suitable name for saving the file to a filesystem.\n  * `id` Unique identifier for the object.\n  * `links` A list of [file links](https://stripe.com/docs/api#file_links) that point at this file.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `purpose` The [purpose](https://stripe.com/docs/file-upload#uploading-a-file) of the uploaded file.\n  * `size` The size of the file object in bytes.\n  * `title` A suitable title for the document.\n  * `type` The returned file type (for example, `csv`, `pdf`, `jpg`, or `png`).\n  * `url` Use your live secret API key to download the file from this URL.\n"
    @type t :: %__MODULE__{
            created: integer,
            expires_at: integer | nil,
            filename: binary | nil,
            id: binary,
            links: term | nil,
            object: binary,
            purpose: binary,
            size: integer,
            title: binary | nil,
            type: binary | nil,
            url: binary | nil
          }
  )

  (
    @typedoc nil
    @type created :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    nil

    @doc "<p>Returns a list of the files that your account has access to. Stripe sorts and returns the files by their creation dates, placing the most recently created files at the top.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/files`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:purpose) =>
                  :account_requirement
                  | :additional_verification
                  | :business_icon
                  | :business_logo
                  | :customer_signature
                  | :dispute_evidence
                  | :document_provider_identity_document
                  | :finance_report_run
                  | :identity_document
                  | :identity_document_downloadable
                  | :issuing_regulatory_reporting
                  | :pci_document
                  | :selfie
                  | :sigma_scheduled_query
                  | :tax_document_user_upload
                  | :terminal_reader_splashscreen,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.File.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/files", [], [])

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

    @doc "<p>Retrieves the details of an existing file object. After you supply a unique file ID, Stripe returns the corresponding file object. Learn how to <a href=\"/docs/file-upload#download-file-contents\">access file contents</a>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/files/{file}`\n"
    (
      @spec retrieve(
              file :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.File.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(file, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/files/{file}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "file",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "file",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [file]
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

    @doc "<p>To upload a file to Stripe, you need to send a request of type <code>multipart/form-data</code>. Include the file you want to upload in the request, and the parameters for creating a file.</p>\n\n<p>All of Stripe’s officially supported Client libraries support sending <code>multipart/form-data</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/files`\n"
    (
      @spec create(opts :: Keyword.t()) ::
              {:ok, Stripe.File.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint("/v1/files")
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_file_upload_request()
      end
    )
  )
end
