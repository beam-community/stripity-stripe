defmodule Stripe.Identity.VerificationReport do
  use Stripe.Entity

  @moduledoc "A VerificationReport is the result of an attempt to collect and verify data from a user.\nThe collection of verification checks performed is determined from the `type` and `options`\nparameters used. You can find the result of each verification check performed in the\nappropriate sub-resource: `document`, `id_number`, `selfie`.\n\nEach VerificationReport contains a copy of any data collected by the user as well as\nreference IDs which can be used to access collected images through the [FileUpload](https://stripe.com/docs/api/files)\nAPI. To configure and create VerificationReports, use the\n[VerificationSession](https://stripe.com/docs/api/identity/verification_sessions) API.\n\nRelated guides: [Accessing verification results](https://stripe.com/docs/identity/verification-sessions#results)."
  (
    defstruct [
      :created,
      :document,
      :id,
      :id_number,
      :livemode,
      :object,
      :options,
      :selfie,
      :type,
      :verification_session
    ]

    @typedoc "The `identity.verification_report` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `document` \n  * `id` Unique identifier for the object.\n  * `id_number` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `options` \n  * `selfie` \n  * `type` Type of report.\n  * `verification_session` ID of the VerificationSession that created this report.\n"
    @type t :: %__MODULE__{
            created: integer,
            document: term,
            id: binary,
            id_number: term,
            livemode: boolean,
            object: binary,
            options: term,
            selfie: term,
            type: binary,
            verification_session: binary | nil
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

    @doc "<p>Retrieves an existing VerificationReport</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/identity/verification_reports/{report}`\n"
    (
      @spec retrieve(
              report :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Identity.VerificationReport.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(report, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/identity/verification_reports/{report}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "report",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "report",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [report]
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

    @doc "<p>List all verification reports.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/identity/verification_reports`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:type) => :document | :id_number,
                optional(:verification_session) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Identity.VerificationReport.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/identity/verification_reports", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
