defmodule AppApi.Repo.Migrations.CreateConversationUserEvents do
  use Ecto.Migration

  def change do
    create table(:conversation_user_events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :conversation_id, references(:conversations, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:conversation_user_events, [:conversation_id])
    create index(:conversation_user_events, [:user_id])
  end
end
