defmodule AppApi.FriendshipFetcher do
  @moduledoc """
  Handles the retrieval and formatting of users from the local storage.
  """
  alias AppApi.{User, Repo, Friendship}
  import Ecto.Query

  def get_all_friends(user) do
    user_with_friends_from = user |> Repo.preload([friendships: approved_request_query()]) |> Repo.preload([:friends])
    user_with_friends_to = user |> Repo.preload([reverse_friendships: approved_request_query()]) |> Repo.preload([:reverse_friends])
    Enum.concat(user_with_friends_from.friends, user_with_friends_to.reverse_friends)
  end

  # already connected (either existing friendship or pending request)
  def have_relationship(user, friend_uuid) do
    if user.id == friend_uuid do
      nil
    else
      query = from c in Friendship, where: c.to_user_id == ^friend_uuid or c.from_user_id == ^friend_uuid
      user_with_friends = user
       |> Repo.preload([friendships: query]) 
       |> Repo.preload([:friends])
       |> Repo.preload([reverse_friendships: query]) 
       |> Repo.preload([:reverse_friends])
      Enum.concat(user_with_friends.friendships, user_with_friends.reverse_friendships) |> List.first
    end
  end

  def get_friendship(user, friend_uuid) do
    if user.id == friend_uuid do
      nil
    else
      query = from c in Friendship, where: c.status == true and (c.to_user_id == ^friend_uuid or c.from_user_id == ^friend_uuid)
      user_with_friends = user
       |> Repo.preload([friendships: query]) 
       |> Repo.preload([:friends])
       |> Repo.preload([reverse_friendships: query]) 
       |> Repo.preload([:reverse_friends])
      Enum.concat(user_with_friends.friendships, user_with_friends.reverse_friendships) |> List.first
    end
  end

  def get_request_received_pending_approval(user, id) do
    query = from c in Friendship, where: c.status == false and c.id == ^id
    user_with_friends = user |> Repo.preload([reverse_friendships: query]) |> Repo.preload([:reverse_friends])
    List.first(user_with_friends.reverse_friendships)
  end

  def get_all_requests_sent_pending_approval(user) do
    case user |> Repo.preload([friendships: pending_request_query()]) |> Repo.preload([:friends]) do
      nil -> []
      res -> res.friendships
    end
  end

  def get_all_requests_received_pending_approval(user) do
    case (user |> Repo.preload([reverse_friendships: pending_request_query()]) |> Repo.preload([:reverse_friends])) do
      nil -> []
      res -> res.reverse_friendships
    end            
  end

  def create_friendship(attrs \\ %{}) do
    # @TODO: check if relationship exists already
    %Friendship{}
    |> Friendship.changeset(attrs)
    |> Repo.insert()
  end

  def update_friendship(%Friendship{} = friendship, attrs) do
    friendship
    |> Friendship.changeset(attrs)
    |> Repo.update()
  end

  def delete_friendship(%Friendship{} = friendship) do
    Repo.delete(friendship)
  end

  def pending_request_query() do
    from c in Friendship, where: c.status == false
  end

  def approved_request_query() do
    from c in Friendship, where: c.status == true
  end

end
