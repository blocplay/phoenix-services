defmodule AppApi.ConversationMessage do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.{User, ConversationMessageEvent}


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "conversation_messages" do
    field :content, :string
    field :media, :string
    field :ref, :string
    field :type, :string
    belongs_to :user, User
    has_one :conversation_message_event, ConversationMessageEvent, foreign_key: :message_id, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(conversation_message, attrs) do
    conversation_message
    |> cast(attrs, [:ref, :type, :content, :media, :user_id])
    |> validate_required([:type, :content])
    |> cast_assoc(:user, required: false)
  end
end
