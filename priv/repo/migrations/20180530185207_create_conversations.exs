defmodule AppApi.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :creator_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:conversations, [:creator_id])
  end
end
