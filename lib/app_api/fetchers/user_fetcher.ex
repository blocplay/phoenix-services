defmodule AppApi.UserFetcher do
  @moduledoc """
  Handles the retrieval and formatting of users from the local storage.
  """
  alias AppApi.{User, Repo, EWallet, Randomizer}

  def all() do
    
  end

  def get(uuid) do
    User |> Repo.get_by(id: uuid)
  end

  def get_by_email(email) do
    User |> Repo.get_by(email: email)
  end

  def get_by_hash(hash) do
    User |> Repo.get_by(auth_token_hash: hash)
  end

  def search(params) do
    User
    |> User.search(params)
    |> Repo.all()
  end

  def get_by_email_password(%{email: email, password: password}) do
    with user <- get_by_email(email),
      check_password_matches_hash(password, user.password_hash)
     do
      user
    else
      err -> err
    end
  end

  def upsert(user_info) do
    user = case Map.has_key?(user_info, :id) do
      true -> get(user_info.id)
      false -> %User{}
    end

    result = case user  do
        nil  -> %User{}
        user -> user
      end
      |> User.changeset(user_info)
      |> Repo.insert_or_update
    case result do
      {:ok, model}        -> {:ok, model} # Inserted or updated with success
      {:error, changeset} -> changeset # Something went wrong
    end
  end

  def generate_password_hash(password) do
    :crypto.hash(:md5, password) |> Base.encode16()
  end

  def check_password_matches_hash(password, hash) do
    generate_password_hash(password) == hash
  end

end
