defmodule AppApi.EWallet do
  require Logger

  def login(%{provider_user_id: provider_user_id} = payload) do
    Logger.debug "login in with ewallet: #{provider_user_id}"
    result = perform_request(%{endpoint: "api/login", payload: payload})
    Logger.debug inspect result
    result
  end

  def signup(%{provider_user_id: provider_user_id, username: username, metadata: metadata} = payload) do
    perform_request(%{endpoint: "api/user.create", payload: payload})
  end

  def me(auth_token) do
    perform_request(%{endpoint: "api/me.get", payload: %{}, headers: ewallet_api_client_header(auth_token)})
  end

  def get_user(auth_token, user_id) do
    perform_request(%{endpoint: "api/user.get", payload: %{id: user_id}, headers: ewallet_api_client_header(auth_token)})
  end



  # performs the requests to the right APIs (ewallet/admin) with the right headers
  defp perform_request(%{endpoint: endpoint, payload: payload}) when "api/user.create" == endpoint or "api/login" == endpoint do
    url = "#{Application.get_env(:app_api, :ewallet)[:base_url]}#{endpoint}"
    headers = ewallet_api_server_header()
    body = Poison.encode!(payload)
    case HTTPoison.post(url, body, headers) do
      {:ok, response} -> Poison.decode!(response.body)
      err -> err
    end
  end
  defp perform_request(%{endpoint: endpoint, payload: payload, headers: headers}) do
    url = "#{Application.get_env(:app_api, :ewallet)[:base_url]}#{endpoint}"
    body = Poison.encode!(payload)
    {:ok, response} =  HTTPoison.post(url, body, headers)
    Poison.decode!(response.body)
  end

  def ewallet_api_server_header() do
    [
      "Authorization": ewallet_api_server_auth_header(), 
      "Content-Type": "application/vnd.tokenplay.v1+json",
      "Accept": "application/vnd.tokenplay.v1+json"
    ]    
  end

  def ewallet_api_client_header(auth_token) do
    [
      "Authorization": ewallet_api_client_auth_header(auth_token), 
      "Content-Type": "application/vnd.tokenplay.v1+json",
      "Accept": "application/vnd.tokenplay.v1+json"
    ]    
  end

  # defines the eWallet API Client Auth Header
  defp ewallet_api_client_auth_header(auth_token) do
    api_key = Application.get_env(:app_api, :ewallet)[:api_key]
    key = Base.encode64("#{api_key}:#{auth_token}")
    "PLAYClient #{key}"
  end

  # defines the eWallet API Server Auth Header
  defp ewallet_api_server_auth_header do
    access_key = Application.get_env(:app_api, :ewallet)[:access_key]
    secret_key = Application.get_env(:app_api, :ewallet)[:secret_key]
    key = Base.encode64("#{access_key}:#{secret_key}")
    "PLAYServer #{key}"
  end

end
