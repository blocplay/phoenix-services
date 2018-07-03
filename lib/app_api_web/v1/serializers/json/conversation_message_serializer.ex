defmodule AppApiWeb.V1.JSON.ConversationMessageSerializer do
  alias AppApi.ConversationMessage, as: CM
  alias AppApiWeb.V1.JSON.UserSerializer
  alias AppApi.Convert

  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(%CM{} = c) when not is_nil(c) do
    %{
      id: c.id,
      creationDate: Convert.to_timestamp(c.inserted_at),
      userId: c.user_id,
      type: c.type,
      content: c.content
    }
  end
  def serialize() do %{} end


end
