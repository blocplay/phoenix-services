defmodule AppApi.Repo.Migrations.CreateConversationMessageEvents do
  use Ecto.Migration

  def change do
    create table(:conversation_message_events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :message_id, references(:conversation_messages, on_delete: :nothing, type: :binary_id)
      add :conversation_id, references(:conversations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:conversation_message_events, [:message_id])
    create index(:conversation_message_events, [:conversation_id])
  end
end
