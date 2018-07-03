defmodule AppApi.SessionFetcher do
  @moduledoc """
  Handles the retrieval and formatting of users from the local storage.
  """
  alias AppApi.{User, Repo, EWallet, Randomizer, Session}
  require Logger

  def get_by_hash(hash) do
    Session |> Repo.get_by(auth_token_hash: hash)
  end

  def get_user_by_hash(hash) do
    case get_by_hash(hash) do
      %Session{} = session -> 
        session = session |> Repo.preload(:user)
        session.user
      _ -> nil
    end
  end

  def create(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

end
