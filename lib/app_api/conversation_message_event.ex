defmodule AppApi.ConversationMessageEvent do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.{Conversation, ConversationMessage}

  # consts
  def message_sent, do: 'message:sent'
  def message_updated, do: 'message:updated'
  def message_deleted, do: 'message:deleted'



  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "conversation_message_events" do
    field :type, :string
    belongs_to :conversation, Conversation
    belongs_to :message, ConversationMessage

    timestamps()
  end

  @doc false
  def changeset(conversation_message_event, attrs) do
    conversation_message_event
    |> cast(attrs, [:type, :conversation_id])
    |> validate_required([:type])
    |> cast_assoc(:conversation, required: false)
    |> cast_assoc(:message, required: false)
  end
end
