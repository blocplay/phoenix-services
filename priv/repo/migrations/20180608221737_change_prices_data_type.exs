defmodule AppApi.Repo.Migrations.ChangePricesDataType do
  use Ecto.Migration

  def change do
		alter table(:users) do
		  modify :tokenBalance, :string
		end
		alter table(:games) do
		  modify :price, :string
		end
  end
end
