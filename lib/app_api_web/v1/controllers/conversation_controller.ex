defmodule AppApiWeb.V1.ConversationController do
  use AppApiWeb, :controller
  require AppApi.EWallet
  alias AppApi.{ConversationFetcher, Repo, Conversation}
  alias AppApiWeb.V1.JSON.{ConversationSerializer, ResponseSerializer}
  require Logger

  def create(conn, %{"title" => title, "userIds" => user_ids, "userAttributes" => user_attrs }) do
    # @TODOS:
    # 1. check all users are friends with this user
    # 2. check if there's any existing conversation with these exact same users and return it if so
    # 3. create new conversation if not
    json conn, ResponseSerializer.serialize(ConversationSerializer.serialize(conn.assigns[:user], ConversationFetcher.create(conn.assigns[:user], %{title: title, participants: user_ids})), "ok")
  end

  def get(conn, %{"conversation_id" => conversation_id}) do
    with %Conversation{} = conversation <- ConversationFetcher.get(conn.assigns[:user], conversation_id) do
      json conn, ResponseSerializer.serialize(ConversationSerializer.serialize(conn.assigns[:user], conversation), "ok")
    end
    json conn, ResponseSerializer.serialize(%{description: "Conversation not found"}, "error")
  end

  def delete(conn, %{"conversation_id" => conversation_id}) do
    with %Conversation{} = conversation <- ConversationFetcher.get(conversation_id) do
      case ConversationFetcher.delete_conversation(conversation) do
        {:ok, _} -> json conn, ResponseSerializer.serialize(%{}, "ok")
        err -> json conn, ResponseSerializer.serialize(err, "error")
      end
    end
    json conn, ResponseSerializer.serialize(%{description: "Conversation not found"}, "error")
  end

  def getAll(conn, _) do
    user = conn.assigns[:user]
    user = user |> Repo.preload(:conversations)
    json conn, ResponseSerializer.serialize(Enum.map(user.conversations, fn(c) -> ConversationSerializer.serialize(conn.assigns[:user], c) end), "ok")
  end

end
