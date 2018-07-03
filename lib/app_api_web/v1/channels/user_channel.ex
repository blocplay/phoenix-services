defmodule AppApiWeb.UserChannel do
  use AppApiWeb, :channel
  require IEx

  def join("user.socket/" <> user_id, auth_message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_info(:after_join, socket) do
    {:noreply, socket} # :noreply
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

end
