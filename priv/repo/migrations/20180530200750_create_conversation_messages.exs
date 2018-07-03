defmodule AppApi.Repo.Migrations.CreateConversationMessages do
  use Ecto.Migration

  def change do
    create table(:conversation_messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :ref, :string
      add :type, :string
      add :content, :text
      add :media, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:conversation_messages, [:user_id])
  end
end
