defmodule AppApi.Repo.Migrations.AddPriceToGames do
  use Ecto.Migration

  def change do
		alter table(:games) do
		  add :price, :integer
		end
  end
end
