defmodule AppApi.GameFetcher do
  @moduledoc """
  Handles the retrieval and formatting of users from the local storage.
  """
  alias AppApi.{User, Repo, EWallet, Randomizer, Game, Blockchain}

  def get(id) do
    Game |> Repo.get(id)
  end

  def get_from_blockchain_id(id) do
    Game |> Repo.get_by(blockchain_id: id)
  end

  def get_by_name(name) do
    Game |> Repo.get_by(name: name)
  end

  def all() do
    Game |> Repo.all
  end

  def get_my_games_from_blockchain(%User{} = user) do
    with %{"result" => games} <- Blockchain.getOwnedGames( %{ token: user.blockchain_token } ) do
      games |> Enum.map(fn(bc_game) -> 
        game_info = bc_game["game"]
        %{
          status: bc_game["status"],
          game: get_from_blockchain_id(bc_game["game"]["gameId"])
        }
      end)
    else 
      err -> %{}
    end    
  end

  def update(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end


end
