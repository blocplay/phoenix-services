defmodule AppApi.Repo.Migrations.CreateCartItems do
  use Ecto.Migration

  def change do
    create table(:cart_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :qty, :integer
      add :cart_id, references(:carts, on_delete: :nothing, type: :binary_id)
      add :game_id, references(:games, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:cart_items, [:cart_id])
    create index(:cart_items, [:game_id])
  end
end
