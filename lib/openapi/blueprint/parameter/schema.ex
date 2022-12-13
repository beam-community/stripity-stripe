defmodule OpenApiGen.Blueprint.Parameter.Schema do
  @moduledoc false
  defstruct [:name, :title, :type, items: [], properties: [], any_of: []]
end
