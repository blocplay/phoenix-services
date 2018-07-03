defmodule AppApiWeb.V1.JSON.UserGameSerializer do
  alias AppApi.{Conversation, Repo, Game}
  alias AppApi.Convert
  alias AppApiWeb.V1.JSON.GameSerializer
  require Logger
  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(%{} = c) when not is_nil(c) do
    %{
      status: c.status,
      game: GameSerializer.serialize(c.game),
    }
  end
  def serialize() do %{} end


end
