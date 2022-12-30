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
end
