defmodule AppApi.Repo.Migrations.AddCurrentCartToUsers do
  use Ecto.Migration

  def change do
		alter table(:users) do
		  add :current_cart_id, references(:carts, on_delete: :nothing, type: :binary_id)
		end
  end
end
