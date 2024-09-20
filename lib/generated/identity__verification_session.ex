defmodule Stripe.Identity.VerificationSession do
  use Stripe.Entity

  @moduledoc "A VerificationSession guides you through the process of collecting and verifying the identities\nof your users. It contains details about the type of verification, such as what [verification\ncheck](/docs/identity/verification-checks) to perform. Only create one VerificationSession for\neach verification in your system.\n\nA VerificationSession transitions through [multiple\nstatuses](/docs/identity/how-sessions-work) throughout its lifetime as it progresses through\nthe verification flow. The VerificationSession contains the user's verified data after\nverification checks are complete.\n\nRelated guide: [The Verification Sessions API](https://stripe.com/docs/identity/verification-sessions)"
  (
    defstruct [
      :client_reference_id,
      :client_secret,
      :created,
      :id,
      :last_error,
      :last_verification_report,
      :livemode,
      :metadata,
      :object,
      :options,
      :provided_details,
      :redaction,
      :related_customer,
      :status,
      :type,
      :url,
      :verification_flow,
      :verified_outputs
    ]

    @typedoc "The `identity.verification_session` type.\n\n  * `client_reference_id` A string to reference this user. This can be a customer ID, a session ID, or similar, and can be used to reconcile this verification with your internal systems.\n  * `client_secret` The short-lived client secret used by Stripe.js to [show a verification modal](https://stripe.com/docs/js/identity/modal) inside your app. This client secret expires after 24 hours and can only be used once. Don’t store it, log it, embed it in a URL, or expose it to anyone other than the user. Make sure that you have TLS enabled on any page that includes the client secret. Refer to our docs on [passing the client secret to the frontend](https://stripe.com/docs/identity/verification-sessions#client-secret) to learn more.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `id` Unique identifier for the object.\n  * `last_error` If present, this property tells you the last error encountered when processing the verification.\n  * `last_verification_report` ID of the most recent VerificationReport. [Learn more about accessing detailed verification results.](https://stripe.com/docs/identity/verification-sessions#results)\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `options` A set of options for the session’s verification checks.\n  * `provided_details` Details provided about the user being verified. These details may be shown to the user.\n  * `redaction` Redaction status of this VerificationSession. If the VerificationSession is not redacted, this field will be null.\n  * `related_customer` Token referencing a Customer resource.\n  * `status` Status of this VerificationSession. [Learn more about the lifecycle of sessions](https://stripe.com/docs/identity/how-sessions-work).\n  * `type` The type of [verification check](https://stripe.com/docs/identity/verification-checks) to be performed.\n  * `url` The short-lived URL that you use to redirect a user to Stripe to submit their identity information. This URL expires after 48 hours and can only be used once. Don’t store it, log it, send it in emails or expose it to anyone other than the user. Refer to our docs on [verifying identity documents](https://stripe.com/docs/identity/verify-identity-documents?platform=web&type=redirect) to learn how to redirect users to Stripe.\n  * `verification_flow` The configuration token of a Verification Flow from the dashboard.\n  * `verified_outputs` The user’s verified data.\n"
    @type t :: %__MODULE__{
            client_reference_id: binary | nil,
            client_secret: binary | nil,
            created: integer,
            id: binary,
            last_error: term | nil,
            last_verification_report: (binary | Stripe.Identity.VerificationReport.t()) | nil,
            livemode: boolean,
            metadata: term,
            object: binary,
            options: term | nil,
            provided_details: term | nil,
            redaction: term | nil,
            related_customer: binary | nil,
            status: binary,
            type: binary,
            url: binary | nil,
            verification_flow: binary,
            verified_outputs: term | nil
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
    @typedoc nil
    @type document :: %{
            optional(:allowed_types) => list(:driving_license | :id_card | :passport),
            optional(:require_id_number) => boolean,
            optional(:require_live_capture) => boolean,
            optional(:require_matching_selfie) => boolean
          }
  )

  (
    @typedoc "A set of options for the session’s verification checks."
    @type options :: %{optional(:document) => document | binary}
  )

  (
    @typedoc "Details provided about the user being verified. These details may be shown to the user."
    @type provided_details :: %{optional(:email) => binary, optional(:phone) => binary}
  )

  (
    nil

    @doc "<p>Returns a list of VerificationSessions</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/identity/verification_sessions`\n"
    (
      @spec list(
              params :: %{
                optional(:client_reference_id) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:related_customer) => binary,
                optional(:starting_after) => binary,
                optional(:status) => :canceled | :processing | :requires_input | :verified
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Identity.VerificationSession.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/identity/verification_sessions", [], [])

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

    @doc "<p>Retrieves the details of a VerificationSession that was previously created.</p>\n\n<p>When the session status is <code>requires_input</code>, you can use this method to retrieve a valid\n<code>client_secret</code> or <code>url</code> to allow re-submission.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/identity/verification_sessions/{session}`\n"
    (
      @spec retrieve(
              session :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Identity.VerificationSession.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/identity/verification_sessions/{session}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
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

    @doc "<p>Creates a VerificationSession object.</p>\n\n<p>After the VerificationSession is created, display a verification modal using the session <code>client_secret</code> or send your users to the session’s <code>url</code>.</p>\n\n<p>If your API key is in test mode, verification checks won’t actually process, though everything else will occur as if in live mode.</p>\n\n<p>Related guide: <a href=\"/docs/identity/verify-identity-documents\">Verify your users’ identity documents</a></p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/identity/verification_sessions`\n"
    (
      @spec create(
              params :: %{
                optional(:client_reference_id) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:options) => options,
                optional(:provided_details) => provided_details,
                optional(:related_customer) => binary,
                optional(:return_url) => binary,
                optional(:type) => :document | :id_number,
                optional(:verification_flow) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Identity.VerificationSession.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/identity/verification_sessions", [], [])

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

    @doc "<p>Updates a VerificationSession object.</p>\n\n<p>When the session status is <code>requires_input</code>, you can use this method to update the\nverification check and options.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/identity/verification_sessions/{session}`\n"
    (
      @spec update(
              session :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:options) => options,
                optional(:provided_details) => provided_details,
                optional(:type) => :document | :id_number
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Identity.VerificationSession.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/identity/verification_sessions/{session}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
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

    @doc "<p>A VerificationSession object can be canceled when it is in <code>requires_input</code> <a href=\"/docs/identity/how-sessions-work\">status</a>.</p>\n\n<p>Once canceled, future submission attempts are disabled. This cannot be undone. <a href=\"/docs/identity/verification-sessions#cancel\">Learn more</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/identity/verification_sessions/{session}/cancel`\n"
    (
      @spec cancel(
              session :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Identity.VerificationSession.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def cancel(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/identity/verification_sessions/{session}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
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

    @doc "<p>Redact a VerificationSession to remove all collected information from Stripe. This will redact\nthe VerificationSession and all objects related to it, including VerificationReports, Events,\nrequest logs, etc.</p>\n\n<p>A VerificationSession object can be redacted when it is in <code>requires_input</code> or <code>verified</code>\n<a href=\"/docs/identity/how-sessions-work\">status</a>. Redacting a VerificationSession in <code>requires_action</code>\nstate will automatically cancel it.</p>\n\n<p>The redaction process may take up to four days. When the redaction process is in progress, the\nVerificationSession’s <code>redaction.status</code> field will be set to <code>processing</code>; when the process is\nfinished, it will change to <code>redacted</code> and an <code>identity.verification_session.redacted</code> event\nwill be emitted.</p>\n\n<p>Redaction is irreversible. Redacted objects are still accessible in the Stripe API, but all the\nfields that contain personal data will be replaced by the string <code>[redacted]</code> or a similar\nplaceholder. The <code>metadata</code> field will also be erased. Redacted objects cannot be updated or\nused for any purpose.</p>\n\n<p><a href=\"/docs/identity/verification-sessions#redact\">Learn more</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/identity/verification_sessions/{session}/redact`\n"
    (
      @spec redact(
              session :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Identity.VerificationSession.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def redact(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/identity/verification_sessions/{session}/redact",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
