defmodule AppApiWeb.V1.JSON.UserSerializer do
  @moduledoc """
  Serializes user data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(user) do
    %{
      object: "user",
      id: user.id,
      username: user.email,
      email: user.email,
      displayName:  user.email,
      ethereumAddress: user.ewallet,
      language: "en",
      tokenBalance: user.tokenBalance,
      motto: "motto",
      status: %{
        code: "online",
        displayText: "Playing Half-Life 2"
      },
      avatar: user.avatar
      # auth_token_hash: user.auth_token_hash,
      # auth_token_hash_64: Base.encode64("#{user.email}:#{user.auth_token}"),
      # auth_token: user.auth_token
    }
  end
  def serialize_admin(user) do
    %{
      object: "user",
      id: user.id,
      username: user.email,
      email: user.email,
      displayName:  user.email,
      ethereumAddress: user.ewallet,
      language: "en",
      tokenBalance: user.tokenBalance,
      motto: "motto",
      status: %{
        code: "online",
        displayText: "Playing Half-Life 2"
      },
      avatar: user.avatar,
      blockchain_token: user.blockchain_token
      # auth_token_hash: user.auth_token_hash,
      # auth_token_hash_64: Base.encode64("#{user.email}:#{user.auth_token}"),
      # auth_token: user.auth_token
    }
  end

  def serialize_ewallet_user(user) do
    user_info = user["data"]
    %{
      object: "user",
      id: user_info["id"],
      username: user_info["email"],
      displayName:  user_info["email"]
    }    
  end

end
