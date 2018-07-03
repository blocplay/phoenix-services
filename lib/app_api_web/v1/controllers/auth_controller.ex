defmodule AppApiWeb.V1.AuthController do
  use AppApiWeb, :controller
  alias AppApi.{EWallet, Blockchain, Repo, Session}
  alias AppApi.{UserFetcher, SessionFetcher}
  alias AppApiWeb.V1.JSON.{UserSerializer, ResponseSerializer}
  require Logger

  def login(conn, %{"username" => email, "password" => password}) do
    with user <- UserFetcher.get_by_email(email),
      # check password matches hash
      UserFetcher.check_password_matches_hash(password, user.password_hash),
      # check eWallet auth 
      %{"authentication_token" => auth_token} <- EWallet.login(%{provider_user_id: user.id})["data"],
      # check blockchain auth 
      %{"result" => %{"token" => blockchain_token}} <- Blockchain.login(%{email: email, password: password}),
      %{"result" => %{"account" => %{"walletId" => walletId}}} <- Blockchain.getAccount(%{token: blockchain_token}),
      %{"result" => %{"balance" => balance}} <- Blockchain.getAccountBalance(%{token: blockchain_token}),
      # create new session
      {:ok, session} <- SessionFetcher.create(%{user_id: user.id, auth_token: auth_token, auth_token_hash: Base.encode64("#{user.email}:#{auth_token}")}),
      # update user object
      {:ok, user_with_auth_token} <- UserFetcher.upsert(%{ id: user.id, blockchain_token: blockchain_token, ewallet: walletId, tokenBalance: balance })
    do
      json conn, ResponseSerializer.serialize( %{token: auth_token, user: UserSerializer.serialize(user_with_auth_token)}, "ok")
    else 
      err -> json conn, ResponseSerializer.serialize(err, "error")
    end
  end

  def signup(conn, %{"email" => email, "password" => password} = payload) do

    # check pass strength
    if !Regex.match?(~r/^(?=(.*\d){2})[a-zA-Z\d]{8,20}$/, password) do
      json conn, ResponseSerializer.serialize(%{description: "Password must be between 8-20 characters long and include at least 2 digits"}, "error")
    end

    # check user is new
    if UserFetcher.get_by_email(email) do
      json conn, ResponseSerializer.serialize(%{description: "User already exists"}, "error")
    end      

    # set random avatar from ones available
    random_avatar_id = :rand.uniform(7)
    payload = Map.merge(payload, %{"avatar" => %{ "url" => "https://s3-us-west-1.amazonaws.com/tokenplay-demo-mock-media/mockImagesOldApp/user/profile-avatar-#{random_avatar_id}.jpg"}})
    
    with payload <- (for {key, val} <- payload, into: %{}, do: {String.to_atom(key), val}),
      new_pass_hash <- UserFetcher.generate_password_hash(password),
      {:ok, user} <- UserFetcher.upsert(Map.merge(payload, %{password_hash: new_pass_hash})),
      ewalletUser <- EWallet.signup(%{provider_user_id: user.id, username: email, metadata: %{}}),
      {:ok, user_with_auth_token} <- UserFetcher.upsert(%{id: user.id, }),
      %{"result" => %{"email" => _}} <- Blockchain.signup(%{username: user_with_auth_token.id, email: email, password: password})
    do
      json conn, ResponseSerializer.serialize(%{}, "ok")
    else
      # if it failed, let's ensure no user is kept on our end so we can 
      # recreate user later if needed
      err -> 
        with user <- UserFetcher.get_by_email(email) do
          Repo.delete(user)
        end
        json conn, ResponseSerializer.serialize(err, "error")
    end    
  end

  def logout(_conn, _attrs) do
    raise "Mock server error"
  end

end
