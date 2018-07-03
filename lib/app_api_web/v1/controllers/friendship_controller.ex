defmodule AppApiWeb.V1.FriendshipController do
  use AppApiWeb, :controller
  require AppApi.EWallet
  alias AppApi.{User, FriendshipFetcher}
  alias AppApiWeb.V1.JSON.{UserSerializer, FriendshipRequestSerializer, ResponseSerializer}
  require Logger

  def invite(conn, params) do
  	ids = params["user_ids"]
    with ids when not is_nil(ids) <- ids,
         ids_array <- String.split(ids, ",") do
      ids_array 
      	|> Enum.map(fn(id) -> 
            if id != conn.assigns[:user].id do 
              AppApi.UserFetcher.get(id) 
            else
              %{}
            end 
          end) 
        |> Enum.filter( fn(val) ->  
            case val do
              %User{} -> 
                # check if no relationship exists between both users
                if !FriendshipFetcher.have_relationship(conn.assigns[:user], val.id), do: true, else: false
              _ -> false
            end
          end )
        |> Enum.map(fn(user) -> 
            # send friend request if not friends yet and no request sent pending (both ways)
            FriendshipFetcher.create_friendship(%{from_user_id: conn.assigns[:user].id, to_user_id: user.id, status: false})
          end )
      json conn, %{}
    else
      _ ->
        json conn, %{}
    end
  end

  def getAll(conn, params) do
    friends = FriendshipFetcher.get_all_friends(conn.assigns[:user])
      |> Enum.map(fn(friend) -> UserSerializer.serialize(friend) end )
    json conn, ResponseSerializer.serialize(friends, "ok")
  end
  
  def getRequests(conn, params) do
    friends = FriendshipFetcher.get_all_requests_received_pending_approval(conn.assigns[:user])
      |> Enum.map(fn(friendship) -> FriendshipRequestSerializer.serialize(friendship, 'from') end )
    json conn, ResponseSerializer.serialize(friends, "ok")
  end

  def remove(conn, params) do
    friend_id = params["user_id"]
    friendship = FriendshipFetcher.get_friendship(conn.assigns[:user], friend_id)
    if friendship != nil do
      FriendshipFetcher.delete_friendship(friendship)
    end
    json conn, %{}
  end
 
  def approve(conn, params) do
    approve_reject(conn, params, 'approve')
    json conn, ResponseSerializer.serialize(%{}, "ok")
  end
  
  def reject(conn, params) do
    approve_reject(conn, params, 'reject')
    json conn, ResponseSerializer.serialize(%{}, "ok")
  end

  # approves / rejects requests
  defp approve_reject(conn, params, status) do
    ids = params["request_ids"]
    with ids when not is_nil(ids) <- ids,
         ids_array <- String.split(ids, ",") do
      ids_array 
        |> Enum.map(fn(id) -> 
            if id != conn.assigns[:user].id do 
              friendship = FriendshipFetcher.get_request_received_pending_approval(conn.assigns[:user], id)
              if friendship == nil do
                %{}
              else  
                if status == 'approve' do
                  FriendshipFetcher.update_friendship(friendship, %{status: true})
                else
                  FriendshipFetcher.delete_friendship(friendship)
                end                           
              end
            else
              %{}
            end 
          end) 
      json conn, ResponseSerializer.serialize(%{}, "ok")
    else
      _ ->
        json conn, ResponseSerializer.serialize(%{description: "Something went wrong"}, "error")
    end
    
  end
  
end
