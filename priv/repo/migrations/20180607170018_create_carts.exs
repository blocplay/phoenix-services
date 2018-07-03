defmodule AppApi.Repo.Migrations.CreateCarts do
  use Ecto.Migration

  def change do
    create table(:carts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :owner_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:carts, [:owner_id])
  end
end
