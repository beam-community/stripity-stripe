defmodule Stripe.OpenApi.Path do
  @moduledoc false
  def replace_path_params(path, path_param_defs, path_params_values) do
    {path, []} =
      path_param_defs
      |> Enum.reduce({path, path_params_values}, fn path_param_def,
                                                    {path, [path_param_value | values]} ->
        path_param_name = path_param_def.name

        path = String.replace(path, "{#{path_param_name}}", path_param_value)
        {path, values}
      end)

    path
  end
end
