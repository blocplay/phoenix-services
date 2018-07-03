defmodule AppApi.ConversationUpdateEvent do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.Conversation


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "conversation_update_events" do
    field :type, :string
    belongs_to :conversation, Conversation

    timestamps()
  end

  @doc false
  def changeset(conversation_update_event, attrs) do
    conversation_update_event
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
