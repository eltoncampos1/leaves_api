defmodule Leafs.Boundary.Validator do
  def require(errors, fields, field_name, validator) do
    fields
    |> Map.has_key?(field_name)
    |> check_required_field(fields, errors, field_name, validator)
  end

  def optional(errors, fields, field_name, validator) do
    if Map.has_key?(fields, field_name) do
      require(errors, fields, field_name, validator)
    else
      errors
    end
  end

  def check(true = _valid, _msg), do: :ok
  def check(false = _valid, msg), do: msg

  defp check_required_field(true = _present, fields, errors, field_name, validator) do
    valid = fields |> Map.fetch!(field_name) |> validator.()
    check_field(valid, errors, field_name)
  end

  defp check_required_field(_present, _fields, errors, field_name, _validator)
       when is_list(errors) do
    errors ++ [{field_name, "is required"}]
  end

  defp check_required_field(_present, _fields, _errors, field_name, _validator) do
    [{field_name, "is required"}]
  end

  defp check_field(:ok, _errors, _field_name), do: :ok

  defp check_field({:error, msg}, errors, field_name) do
    errors ++ [{field_name, msg}]
  end

  defp check_field({:errors, msgs}, errors, field_name) do
    errors ++ Enum.map(msgs, &{field_name, &1})
  end
end
