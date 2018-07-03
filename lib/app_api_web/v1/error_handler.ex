defmodule AppApiWeb.V1.ErrorHandler do
  @moduledoc """
  Handles API errors by mapping the error to its response code and description.
  """
  import Ecto.Changeset, only: [traverse_errors: 2]
  import Phoenix.Controller, only: [json: 2]
  import Plug.Conn, only: [halt: 1]
  alias AppApiWeb.V1.JSON.{ErrorSerializer, ResponseSerializer}

  @errors %{
    token_not_found: %{
      code: "minted_token:minted_token_not_found",
      description: "There is no minted token matching the provided token_id."
    }
  }

  # Used for mapping any Ecto.changeset validation
  # to make it more meaningful to send to the client.
  @validation_mapping %{
    unsafe_unique: "already_taken",
    all_or_none: "missing_dependent_params"
  }

  @doc """
  Handles response of invalid parameter error with error details provided.
  """
  def handle_error(conn, :invalid_parameter, changeset) do
    code =
      @errors.invalid_parameter.code
    description =
      stringify_errors(changeset, @errors.invalid_parameter.description <> ".")
    messages =
      error_fields(changeset)

    respond(conn, code, description, messages)
  end

  @doc """
  Handles response with custom error code and description.
  """
  def handle_error(conn, code, description) do
    respond(conn, code, description)
  end

  @doc """
  Handles response of invalid version error with accept header provided.
  """
  def handle_error(conn, :invalid_version) do
    code =
      @errors.invalid_version.code
    description =
      "Invalid API version. Given: \"" <> conn.assigns.accept <> "\"."

    respond(conn, code, description)
  end

  @doc """
  Handles response with default error code and description
  """
  def handle_error(conn, error_name) do
    case Map.fetch(@errors, error_name) do
      {:ok, error} ->
        respond(conn, error.code, error.description)
      _ ->
        handle_error(conn, :internal_server_error, error_name)
    end
  end

  defp stringify_errors(changeset, description) do
    Enum.reduce(changeset.errors, description,
      fn {field, {description, _values}}, acc ->
        acc <> " " <> stringify_field(field) <> " " <> description <> "."
      end)
  end

  defp stringify_field(fields) when is_map(fields) do
    Enum.map_join(fields, ", ", fn({key, _}) -> stringify_field(key) end)
  end
  defp stringify_field(fields) when is_list(fields) do
    Enum.map(fields, &stringify_field/1)
  end
  defp stringify_field(field) when is_atom(field) do
    "`" <> to_string(field) <> "`"
  end
  defp stringify_field({key, _}) do
    "`" <> to_string(key) <> "`"
  end

  defp error_fields(changeset) do
    traverse_errors(changeset, fn {_message, opts} ->
      validation = Keyword.get(opts, :validation)

      # Maps Ecto.changeset validation to be more meaningful
      # to send to the client.
      Map.get(@validation_mapping, validation, validation)
    end)
  end

  defp respond(conn, code, description, messages \\ nil) do
    content =
      code
      |> ErrorSerializer.serialize(description, messages)
      |> ResponseSerializer.serialize(success: false)

    conn |> json(content) |> halt()
  end
end
