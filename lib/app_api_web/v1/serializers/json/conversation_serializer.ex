defmodule AppApiWeb.V1.JSON.ConversationSerializer do
  alias AppApi.{Conversation, Repo, User}
  alias AppApiWeb.V1.JSON.{UserSerializer, ConversationMessageEventSerializer, ConversationMessageSerializer}
  alias AppApi.Convert
  require Logger
  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  # @TODO: latest events should get all types of events and display only the latest 50, plus
  # the latest message needs to get the latest message and show just the text
  def serialize(%User{} = u, %Conversation{} = c) when not is_nil(c) do
    c = c |> Repo.preload(:participants) |> Repo.preload(:conversation_message_events)
    Logger.debug "HERE?"
    Logger.debug inspect c
    %{
      id: c.id,
      title: c.title,
      creationDate: Convert.to_timestamp(c.inserted_at),
      users: Enum.reject(c.participants, fn(user) -> u.id == user.id end)
        |> Enum.map(fn(u) -> UserSerializer.serialize(u) end),
      latestEvents: Enum.map(c.conversation_message_events, fn(m) -> ConversationMessageEventSerializer.serialize(m) end) |> Enum.sort(&(&1.message.creationDate < &2.message.creationDate)),
      isFavorite: false,
      latestMessage: ""
    }
  end
  def serialize() do %{} end


end
