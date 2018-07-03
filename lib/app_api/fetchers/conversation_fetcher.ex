defmodule AppApi.ConversationFetcher do
  @moduledoc """
  Handles the retrieval and formatting of users from the local storage.
  """
  alias AppApi.{User, Repo, Conversation, ConversationMessage}
  alias AppApi.ConversationMessageEvent, as: CME
  import Ecto.Query
  require Logger

  def create_message_event(%Conversation{} = conversation, %User{} = user, %{} = message) do
    full_msg = Map.merge(message, %{"user_id" => user.id})
    cme = %{
      "type" => "message:sent",
      "conversation_id" => conversation.id,
      "message" => full_msg
    }

    %CME{} |> CME.changeset(cme) |> Repo.insert()
  end

  def update_message(%Conversation{} = conversation, %User{} = user, %{"id" => id, "content" => content}) do
    with message <- ConversationMessage |> Repo.get(id) do
      message |> ConversationMessage.changeset(%{content: content}) |> Repo.update()
    else
      err -> err
    end
  end

  def delete_message(%Conversation{} = conversation, %User{} = user, message_id) do
    with message <- ConversationMessage |> Repo.get(message_id) do
      Repo.delete(message)
    else
      err -> err
    end
    
  end

  def create(%User{} = owner, attrs \\ %{}) do
    # @TODO: check if conversation exists already for these exact same users?
    # @TODO: wrap within DB transaction?
    {:ok, conversation} = owner 
      |> Ecto.build_assoc(:conversations_owned, %{title: attrs.title})
      |> Repo.insert()

    all_users = attrs.participants ++ [owner.id]

    participants = Repo.all(from t in User, where: t.id in ^all_users)

    conversation
    |> Repo.preload(:participants) # Load existing data
    |> Ecto.Changeset.change() # Build the changeset
    |> Ecto.Changeset.put_assoc(:participants, participants) # Set the association
    |> Repo.update!
  end

  def add_user(conversation_id, user_id) do
    with conversation <- get(conversation_id),
      user <- User |> Repo.get(user_id)
    do
      conversation = conversation |> Repo.preload(:participants)
      participants = conversation.participants ++ [user]
                  |> Enum.map(&Ecto.Changeset.change/1)
                  
      conversation
        |> Ecto.Changeset.change
        |> Ecto.Changeset.put_assoc(:participants, participants)
        |> Repo.update()
    else
      err -> err
    end
  end

  def remove_user(conversation_id, user_id) do
    from(p in "users_conversations", where: p.user_id == type(^user_id, :binary_id) and p.conversation_id == type(^conversation_id, :binary_id)) |> Repo.delete_all
  end

  def delete_conversation(%Conversation{} = conversation) do
    # @TODO: check user is owner?
    Repo.delete(conversation)
  end

  def get(user, conversation_id) do
    query = from c in Conversation, where: c.id == ^conversation_id 
    user_with_conversations = user |> Repo.preload(conversations: query)
    conversation = List.first(user_with_conversations.conversations) |> Repo.preload(:participants)
  end
  def get(conversation_id) do
    Conversation |> Repo.get(conversation_id)
  end

end
