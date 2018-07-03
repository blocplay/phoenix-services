defmodule AppApi.Blockchain do
  require Logger

  def signup(%{username: username, email: email, password: password} = payload) do
    perform_request(%{endpoint: "signUpUser", payload: [username, email, password]})
  end

  def login(%{email: email, password: password} = payload) do
    perform_request(%{endpoint: "login", payload: [email, password]})
  end

  def getAccount(%{token: token} = payload) do
    perform_request(%{endpoint: "getAccount", payload: [token]})
  end

  def getAccountBalance(%{token: token} = payload) do
    perform_request(%{endpoint: "getAccountBalance", payload: [token]})
  end

  def getOwnedGames(%{token: token} = payload) do
    perform_request(%{endpoint: "getOwnedGames", payload: [token]})
  end

  def buyGame(%{token: token, game_id: game_id} = payload) do
    perform_request(%{endpoint: "buyGame", payload: [token, game_id]})
  end

  # performs the requests to the right APIs (ewallet/admin) with the right headers
  defp perform_request(%{endpoint: endpoint, payload: payload}) do
    url = "#{Application.get_env(:app_api, :blockchain)[:base_url]}#{endpoint}"
    headers = get_headers()
    body = Poison.encode!(get_body(endpoint, payload))
    case HTTPoison.post(url, body, headers, [timeout: 50_000, recv_timeout: 50_000]) do
      {:ok, response} -> Poison.decode!(response.body)
      err -> err
    end
  end
  # defp perform_request(%{endpoint: endpoint, payload: payload, headers: headers}) do
  #   url = "#{Application.get_env(:app_api, :ewallet)[:base_url]}#{endpoint}"
  #   body = Poison.encode!(payload)
  #   {:ok, response} =  HTTPoison.post(url, body, headers)
  #   Poison.decode!(response.body)
  # end

  def get_headers() do
    [
      "Content-Type": "application/json"
    ]    
  end

  def get_body(endpoint, params) do
    %{
      "jsonrpc": "2.0",
      "method": endpoint,
      "params": params,
      "id": 1
    }
  end

end
