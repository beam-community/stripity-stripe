defmodule Stripe.Terminal.Configuration do
  use Stripe.Entity

  @moduledoc "A Configurations object represents how features should be configured for terminal readers."
  (
    defstruct [
      :bbpos_wisepos_e,
      :id,
      :is_account_default,
      :livemode,
      :object,
      :offline,
      :tipping,
      :verifone_p400
    ]

    @typedoc "The `terminal.configuration` type.\n\n  * `bbpos_wisepos_e` \n  * `id` Unique identifier for the object.\n  * `is_account_default` Whether this Configuration is the default for your account\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `offline` \n  * `tipping` \n  * `verifone_p400` \n"
    @type t :: %__MODULE__{
            bbpos_wisepos_e: term,
            id: binary,
            is_account_default: boolean | nil,
            livemode: boolean,
            object: binary,
            offline: term,
            tipping: term,
            verifone_p400: term
          }
  )

  (
    @typedoc "Tipping configuration for AUD"
    @type aud :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "An object containing device type specific settings for BBPOS WisePOS E readers"
    @type bbpos_wisepos_e :: %{optional(:splashscreen) => binary | binary}
  )

  (
    @typedoc "Tipping configuration for CAD"
    @type cad :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for CHF"
    @type chf :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for CZK"
    @type czk :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for DKK"
    @type dkk :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for EUR"
    @type eur :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for GBP"
    @type gbp :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for HKD"
    @type hkd :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for MYR"
    @type myr :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for NOK"
    @type nok :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for NZD"
    @type nzd :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc nil
    @type offline :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Tipping configuration for SEK"
    @type sek :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "Tipping configuration for SGD"
    @type sgd :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc nil
    @type tipping :: %{
            optional(:aud) => aud,
            optional(:cad) => cad,
            optional(:chf) => chf,
            optional(:czk) => czk,
            optional(:dkk) => dkk,
            optional(:eur) => eur,
            optional(:gbp) => gbp,
            optional(:hkd) => hkd,
            optional(:myr) => myr,
            optional(:nok) => nok,
            optional(:nzd) => nzd,
            optional(:sek) => sek,
            optional(:sgd) => sgd,
            optional(:usd) => usd
          }
  )

  (
    @typedoc "Tipping configuration for USD"
    @type usd :: %{
            optional(:fixed_amounts) => list(integer),
            optional(:percentages) => list(integer),
            optional(:smart_tip_threshold) => integer
          }
  )

  (
    @typedoc "An object containing device type specific settings for Verifone P400 readers"
    @type verifone_p400 :: %{optional(:splashscreen) => binary | binary}
  )

  (
    nil

    @doc "<p>Deletes a <code>Configuration</code> object.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/terminal/configurations/{configuration}`\n"
    (
      @spec delete(configuration :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedTerminal.Configuration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(configuration, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/configurations/{configuration}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "configuration",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "configuration",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [configuration]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Returns a list of <code>Configuration</code> objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/terminal/configurations`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:is_account_default) => boolean,
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Terminal.Configuration.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/configurations", [], [])

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

    @doc "<p>Retrieves a <code>Configuration</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/terminal/configurations/{configuration}`\n"
    (
      @spec retrieve(
              configuration :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Configuration.t() | Stripe.DeletedTerminal.Configuration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(configuration, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/configurations/{configuration}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "configuration",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "configuration",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [configuration]
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

    @doc "<p>Creates a new <code>Configuration</code> object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/configurations`\n"
    (
      @spec create(
              params :: %{
                optional(:bbpos_wisepos_e) => bbpos_wisepos_e,
                optional(:expand) => list(binary),
                optional(:offline) => offline | binary,
                optional(:tipping) => tipping | binary,
                optional(:verifone_p400) => verifone_p400
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Configuration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/configurations", [], [])

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

    @doc "<p>Updates a new <code>Configuration</code> object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/configurations/{configuration}`\n"
    (
      @spec update(
              configuration :: binary(),
              params :: %{
                optional(:bbpos_wisepos_e) => bbpos_wisepos_e | binary,
                optional(:expand) => list(binary),
                optional(:offline) => offline | binary,
                optional(:tipping) => tipping | binary,
                optional(:verifone_p400) => verifone_p400 | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.Configuration.t() | Stripe.DeletedTerminal.Configuration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(configuration, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/terminal/configurations/{configuration}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "configuration",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "configuration",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [configuration]
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
