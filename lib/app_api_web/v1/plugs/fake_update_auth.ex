defmodule AppApiWeb.V1.Plug.FakeUpdateAuth do
  @moduledoc """
  This plug checks if valid api key and token were provided.

  If api key and token are valid, the plug assigns the user
  associated with the token to the connection so that downstream
  consumers know which user this request belongs to.
  """
  import Plug.Conn
  import AppApiWeb.V1.ErrorHandler
  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    # @TODO: check token still valid with ewallet api
    conn
    |> parse_header()
  end

  defp parse_header(conn) do
    header =
      conn
      |> get_req_header("authorization")
      |> List.first()
    with header when not is_nil(header) <- header,
         [scheme, content] <- String.split(header, " ", parts: 2),
         true <- scheme in ["Basic"],
         "42352B9D8226D9B0012B3185EA047F569BB0BC2C4B01063E8BAFDA5A5685A21F" <- content
    do
      Logger.warn "validated"
      conn
    else
      _ ->
        conn
        |> assign(:authenticated, false)
        |> handle_error(:invalid_auth_scheme)
    end
  end


end
