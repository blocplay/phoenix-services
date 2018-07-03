defmodule AppApiWeb.ConversationChannel do
  use AppApiWeb, :channel
  alias AppApi.{MessageEvent, ConversationFetcher, UserFetcher, ConversationMessageEventFetcher, Repo}
  alias AppApiWeb.V1.JSON.ConversationMessageEventSerializer, as: CMESerializer
  require Logger

  # @TODO: check if user can join conversation channel
  def join("conversation.socket/" <> conversation_id, auth_message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("shout", payload, socket) do
    broadcast! socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("event", %{ "type" => "message:sent", "message" => %{ "type" => "text", "ref" => ref, "content" => content } } = payload, socket) do
    conversation = get_socket_conversation(socket)
    user = get_user(socket)

    case ConversationFetcher.create_message_event(conversation, user, payload["message"]) do
      {:ok, cme}       -> 
        broadcast! socket, "event", CMESerializer.serialize(cme)
        confirmation = Map.merge(cme, %{"type" => "message:updated", "ref" => ref})
        push socket, "event", confirmation
        {:reply, :ok, socket}
      _ -> {:noreply, socket}
    end
  end

  def handle_in("event", %{ "type" => "message:updated", "message" => %{ "id" => id, "type" => "text", "content" => content } } = payload, socket) do
    conversation = get_socket_conversation(socket)
    user = get_user(socket)

    case ConversationFetcher.update_message(conversation, user, payload["message"]) do
      {:ok, updated_message} -> 
        updated_message = updated_message |> Repo.preload(:conversation_message_event)
        cme = ConversationMessageEventFetcher.get(updated_message.conversation_message_event.id)
        confirmation = Map.merge(cme, %{type: "message:updated"})
        broadcast! socket, "event", CMESerializer.serialize(confirmation)
        {:reply, :ok, socket}
      err -> 
        Logger.warn "Error: #{err}"
        {:noreply, socket}
    end
  end

  def handle_in("event", %{ "type" => "message:deleted", "message" => %{ "id" => id } } = payload, socket) do
    conversation = get_socket_conversation(socket)
    user = get_user(socket)

    case ConversationFetcher.delete_message(conversation, user, id) do
      {:ok, _} -> 
        broadcast! socket, "event", payload
        {:reply, :ok, socket}
      err -> 
        Logger.warn "Error: #{err}"
        {:noreply, socket}
    end
  end

  # user conversation events

  # @TODO: save this as an event
  def handle_in("event", %{ "type" => "user:joined", "userId" => user_id } = payload, socket) do
    conversation = get_socket_conversation(socket)
    user = get_user(socket)

    case ConversationFetcher.add_user(conversation.id, user_id) do
      {:ok, _}       -> 
        broadcast! socket, "event", payload
        {:reply, :ok, socket}
      err -> 
        Logger.warn inspect err        
        {:noreply, socket}
    end
  end

  def handle_in("event", %{ "type" => "user:left", "userId" => user_id } = payload, socket) do
    conversation = get_socket_conversation(socket)
    user = get_user(socket)

    case ConversationFetcher.remove_user(conversation.id, user_id) do
      {1, _}       -> 
        broadcast! socket, "event", payload
        {:reply, :ok, socket}
      err -> 
        Logger.warn inspect err        
        {:noreply, socket}
    end
  end

  def handle_in("event", %{ "type" => "user:entered" } = payload, socket) do
    broadcast! socket, "event", payload
    {:noreply, socket}
  end

  def handle_in("event", %{ "type" => "user:exited" } = payload, socket) do
    broadcast! socket, "event", payload
    {:noreply, socket}
  end

  def handle_in("event", %{ "type" => "user:typingStarted" } = payload, socket) do
    broadcast! socket, "event", payload
    {:noreply, socket}
  end

  def handle_in("event", %{ "type" => "user:typingStopped" } = payload, socket) do
    broadcast! socket, "event", payload
    {:noreply, socket}
  end

  # user joined channel
  def handle_info(:after_join, socket) do
    {:noreply, socket} # :noreply
  end

  def get_user(socket) do
    UserFetcher.get(socket.assigns.user_id)
  end

  defp get_socket_conversation(socket) do
    "conversation.socket/" <> conversation_id = socket.topic
    ConversationFetcher.get(conversation_id)
  end

end




