defmodule AppApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :avatar, :map
      add :motto, :string
      add :status, :map
      add :language, :string
      add :tokenBalance, :integer

      timestamps()
    end

  end
end
