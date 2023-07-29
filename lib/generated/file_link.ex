defmodule Stripe.FileLink do
  use Stripe.Entity

  @moduledoc "To share the contents of a `File` object with non-Stripe users, you can\ncreate a `FileLink`. `FileLink`s contain a URL that can be used to\nretrieve the contents of the file without authentication."
  (
    defstruct [:created, :expired, :expires_at, :file, :id, :livemode, :metadata, :object, :url]

    @typedoc "The `file_link` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `expired` Whether this link is already expired.\n  * `expires_at` Time at which the link expires.\n  * `file` The file object this link points to.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `url` The publicly accessible URL to download the file.\n"
    @type t :: %__MODULE__{
            created: integer,
            expired: boolean,
            expires_at: integer | nil,
            file: binary | Stripe.File.t(),
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
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

    @doc "<p>Retrieves the file link with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/file_links/{link}`\n"
    (
      @spec retrieve(
              link :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.FileLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(link, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/file_links/{link}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "link",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "link",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [link]
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

    @doc "<p>Creates a new file link object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/file_links`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:expires_at) => integer,
                optional(:file) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.FileLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/file_links", [], [])

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

    @doc "<p>Updates an existing file link object. Expired links can no longer be updated.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/file_links/{link}`\n"
    (
      @spec update(
              link :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:expires_at) => :now | integer | binary,
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.FileLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(link, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/file_links/{link}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "link",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "link",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [link]
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

    @doc "<p>Returns a list of file links.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/file_links`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:expired) => boolean,
                optional(:file) => binary,
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.FileLink.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/file_links", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
