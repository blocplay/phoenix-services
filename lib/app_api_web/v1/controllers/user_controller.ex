defmodule AppApiWeb.V1.UserController do
  use AppApiWeb, :controller
  alias AppApi.{EWallet, Blockchain, UserFetcher, Repo, User}
  alias AppApiWeb.V1.JSON.{UserSerializer, ResponseSerializer}
  require Logger

  def all(conn,%{}) do
    json conn, ResponseSerializer.serialize(%{users: Enum.map(User |> Repo.all, fn(user) -> UserSerializer.serialize_admin(user) end)}, "ok")
  end

  def get(conn, params) do
  	ids = params["user_ids"]

    with ids when not is_nil(ids) <- ids,
         ids_array <- String.split(ids, ",") do
      users_info = ids_array 
      	|> Enum.map(fn(id) -> UserFetcher.get(id) end) 
      	|> Enum.reject(fn(res) -> res == nil end)
      	|> Enum.map(fn(user) -> UserSerializer.serialize(user) end) 
      json conn, ResponseSerializer.serialize(%{users: users_info}, "ok") 
    else
      _ ->

        json conn, ResponseSerializer.serialize(%{description: "Something went wrong"}, "error")
    end
  end

  def search(conn, %{"query" => query, "page" => page}) do
    json conn, ResponseSerializer.serialize(%{users: Enum.map(UserFetcher.search(query), fn(user) -> UserSerializer.serialize(user) end)}, "ok")
  end

  def me(conn, _attrs) do
    user = conn.assigns[:user]
    auth_token = conn.private[:auth_token]
    with %{"id" => eWallet_provider_user_id} <- EWallet.me(auth_token)["data"],
      %{"result" => %{"balance" => balance}} <- Blockchain.getAccountBalance(%{token: user.blockchain_token}),
      {:ok, user_with_auth_token} <- UserFetcher.upsert(%{id: user.id, tokenBalance: balance })
    do
      json conn, ResponseSerializer.serialize(UserSerializer.serialize(user_with_auth_token), "ok") 
    end
    json conn, ResponseSerializer.serialize(%{description: "Something went wrong"}, "error")
    
  end


end
