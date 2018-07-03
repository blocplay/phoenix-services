defmodule AppApi.Repo.Migrations.CreateFriendships do
  use Ecto.Migration

  def change do
    create table(:friendships, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :boolean, default: false, null: false
      add :from_user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :to_user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:friendships, [:from_user_id])
    create index(:friendships, [:to_user_id])
  end
end
