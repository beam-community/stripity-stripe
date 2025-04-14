defmodule OpenApiGen.Blueprint.Operation do
  @moduledoc false
  defstruct [
    :id,
    :method,
    :path,
    :name,
    :description,
    :parameters,
    :path_parameters,
    :query_parameters,
    :deprecated,
    :operation,
    :body_parameters,
    :success_response
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          method: String.t(),
          path: String.t(),
          name: String.t(),
          description: String.t(),
          parameters: list(),
          path_parameters: list(),
          query_parameters: list(),
          deprecated: boolean(),
          operation: String.t(),
          body_parameters: list(),
          success_response: list()
        }
end
