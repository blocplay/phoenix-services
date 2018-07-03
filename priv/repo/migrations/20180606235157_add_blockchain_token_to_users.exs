defmodule AppApi.Repo.Migrations.AddBlockchainTokenToUsers do
  use Ecto.Migration

  def change do
		alter table(:users) do
		  add :blockchain_token, :string
		end
  end
end
