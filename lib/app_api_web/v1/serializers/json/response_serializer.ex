defmodule AppApiWeb.V1.JSON.ResponseSerializer do
  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(data, success: "ok") do
    %{
      result: "ok",
      version: @version,
      data: data
    }
  end
  def serialize(data, "ok") do
    %{
      result: "ok",
      version: @version,
      data: data
    }
  end
  def serialize(error, "error") do
    %{
      result: "error",
      version: @version,
      error: error
    }
  end
  def serialize(error, success: false) do
    %{
      result: "error",
      version: @version,
      error: error
    }
  end
end
