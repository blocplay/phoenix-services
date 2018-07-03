defmodule AppApiWeb.V1.Plug.Auth do
  @moduledoc """
  This plug checks if valid api key and token were provided.

  If api key and token are valid, the plug assigns the user
  associated with the token to the connection so that downstream
  consumers know which user this request belongs to.
  """
  import Plug.Conn
  import AppApiWeb.V1.ErrorHandler
  alias AppApi.SessionFetcher

  def init(opts), do: opts

  def call(conn, _opts) do
    # @TODO: check token still valid with ewallet api
    conn
    |> parse_header()
    |> authenticate_token()
  end

  defp parse_header(conn) do
    header =
      conn
      |> get_req_header("authorization")
      |> List.first()

    with header when not is_nil(header) <- header,
         [scheme, content] <- String.split(header, " ", parts: 2),
         true <- scheme in ["Basic"],
         {:ok, decoded} <- Base.decode64(content),
         [username, token] <- String.split(decoded, ":", parts: 2) do
      conn
      |> put_private(:auth_token_hash, content)
      |> put_private(:auth_email, username)
      |> put_private(:auth_token, token)
    else
      _ ->
        conn
        |> assign(:authenticated, false)
        |> handle_error(:invalid_auth_scheme)
    end
  end

  # Skip token auth if it already failed since API key validation
  defp authenticate_token(%{assigns: %{authenticated: false}} = conn), do: conn
  # regular conn auth
  defp authenticate_token(conn) do
    auth_token_hash = conn.private[:auth_token_hash]

    case SessionFetcher.get_user_by_hash(auth_token_hash) do
      nil ->
        conn
        |> assign(:authenticated, false)
        |> handle_error(:access_token_not_found)
      user ->
        conn
        |> assign(:authenticated, :app)
        |> assign(:user, user)
    end
  end

end
