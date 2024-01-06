defmodule Leafs.Boundary.LeafValidator do
  import Leafs.Boundary.Validator

  def errors(fields) when is_map(fields) do
    []
    |> require(fields, "name", &is_valid_string/1)
    |> require(fields, "color", &is_valid_string/1)
    |> require(fields, "origin", &is_valid_string/1)
  end

  def errors(_fields), do: [{nil, "A map of fields is required"}]

  defp is_valid_string(string) when is_binary(string) do
    check(String.match?(string, ~r{\S}), {:error, "can't be blank"})
  end

  defp is_valid_string(_str), do: {:error, "must be a string"}
end
