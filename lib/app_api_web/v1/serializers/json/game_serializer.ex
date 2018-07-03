defmodule AppApiWeb.V1.JSON.GameSerializer do
  alias AppApi.{Conversation, Repo, Game}
  alias AppApi.Convert
  require Logger
  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(%Game{} = c) when not is_nil(c) do
    main_object = %{
      id: c.id,
      name: c.name,
      price: c.price,
      description: c.description,
    }
    if c.metadata == nil do
      main_object
    else
      Map.merge(c.metadata, main_object)
    end
  end
  def serialize() do %{} end


end
