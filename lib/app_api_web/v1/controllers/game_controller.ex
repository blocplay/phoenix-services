defmodule AppApiWeb.V1.GameController do
  use AppApiWeb, :controller
  alias AppApi.{GameFetcher, Repo, User}
  alias AppApiWeb.V1.JSON.{GameSerializer, UserGameSerializer, ResponseSerializer}
  require Logger

  def getAll(conn, _params) do
    games = GameFetcher.all()
      |> Enum.map(fn(game) -> GameSerializer.serialize(game) end )
    json conn, ResponseSerializer.serialize(games, "ok")
  end

  def getMine(conn, _params) do
    with user <- conn.assigns[:user],
      games <- GameFetcher.get_my_games_from_blockchain(user)
    do
      json conn, ResponseSerializer.serialize(Enum.map(games, fn(game) -> UserGameSerializer.serialize(game) end ), "ok")
    end
    json conn, ResponseSerializer.serialize(%{description: "Failed to get games"}, "error")
  end

  def get(conn, params) do
    ids = params["game_ids"]
    with ids when not is_nil(ids) <- ids,
         ids_array <- String.split(ids, ",") do
      games_info = ids_array 
        |> Enum.map(fn(id) -> GameFetcher.get(id) end) 
        |> Enum.reject(fn(res) -> res == nil end)
        |> Enum.map(fn(game) -> GameSerializer.serialize(game) end) 
      json conn, ResponseSerializer.serialize(games_info, "ok")
    end
    json conn, ResponseSerializer.serialize([], "ok")
  end

  def update(conn, %{"id" => id, "attributes" => attrs}) do
    g = GameFetcher.get(id)

    case GameFetcher.update(g, attrs) do
      {:ok, game} -> json conn, ResponseSerializer.serialize(GameSerializer.serialize(game), "ok")
      err -> json conn, ResponseSerializer.serialize(err, "error")
    end
  end

end
