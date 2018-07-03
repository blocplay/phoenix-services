defmodule AppApiWeb.V1.JSON.FriendshipRequestSerializer do
  alias AppApiWeb.V1.JSON.UserSerializer
  alias AppApi.Convert
  @moduledoc """
  Serializes user data into V1 JSON response format.
  """
  use AppApiWeb.V1
  alias AppApi.Convert

  def serialize(friendship, 'from') do
    %{
      id: friendship.id,
      date: Convert.to_timestamp(friendship.inserted_at),
      user: UserSerializer.serialize(friendship.from_user)
    }
  end
  def serialize(friendship, 'to') do
    %{
      id: friendship.id,
      date: Convert.to_timestamp(friendship.inserted_at),
      user: UserSerializer.serialize(friendship.to_user)
    }
  end

end
