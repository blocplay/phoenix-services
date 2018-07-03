defmodule AppApi.Repo.Migrations.CreateConversationUpdateEvents do
  use Ecto.Migration

  def change do
    create table(:conversation_update_events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :conversation_id, references(:conversations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:conversation_update_events, [:conversation_id])
  end
end
