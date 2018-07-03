defmodule AppApi.Repo.Migrations.ChangeGamePriceDataType do
  use Ecto.Migration

  def change do
		alter table(:games) do
		  modify :price, :bigint
		end
  end
end
