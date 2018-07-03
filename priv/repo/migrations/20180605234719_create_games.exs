defmodule AppApi.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :blockchain_id, :integer
      add :name, :string
      add :publisher, :string
      add :media_activity, :string
      add :media_cover, :string
      add :media_store, :string

      timestamps()
    end

  end
end
