defmodule AppApi.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.{User, ConversationMessageEvent}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "conversations" do
    field :title, :string

    many_to_many :participants, User, join_through: "users_conversations", on_delete: :delete_all
    belongs_to :creator, User
    has_many :conversation_message_events, ConversationMessageEvent, on_delete: :delete_all


    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:title, :creator_id])
    |> validate_required([:title])
    |> cast_assoc(:participants, required: false)
    |> cast_assoc(:creator, required: false)
  end

end
