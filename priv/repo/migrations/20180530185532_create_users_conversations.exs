defmodule AppApi.Repo.Migrations.CreateUsersConversations do
  use Ecto.Migration

  def change do
    create table(:users_conversations) do
      add :conversation_id, references(:conversations, type: :binary_id)
      add :user_id, references(:users, type: :binary_id)
    end

    create unique_index(:users_conversations, [:user_id, :conversation_id])
  end
end
