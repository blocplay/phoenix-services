defmodule AppApiWeb.V1.JSON.ConversationMessageEventSerializer do
  alias AppApi.ConversationMessageEvent, as: CME
  alias AppApi.Repo
  alias AppApiWeb.V1.JSON.ConversationMessageSerializer, as: CMSerializer
  alias AppApiWeb.V1.JSON.UserSerializer
  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(%CME{} = c) when not is_nil(c) do
    c = c |> Repo.preload(:message)
    %{
      id: c.id,
      type: c.type,
      message: CMSerializer.serialize(c.message)
    }
  end
  def serialize() do %{} end


end
