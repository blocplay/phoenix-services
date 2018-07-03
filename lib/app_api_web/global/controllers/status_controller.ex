defmodule AppApiWeb.StatusController do
  use AppApiWeb, :controller

  def status(conn, _attrs) do
    json conn, %{
      success: true,
      services: %{
        store: true,
        messaging: true
      }
    }
  end

end
