defmodule AppApi.ConversationUserEvent do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.Conversation


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "conversation_user_events" do
    field :type, :string
    field :user, :binary_id
    belongs_to :conversation, Conversation

    timestamps()
  end

  @doc false
  def changeset(conversation_user_event, attrs) do
    conversation_user_event
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
