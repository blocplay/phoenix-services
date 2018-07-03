defmodule AppApi.Repo.Migrations.ChangeUserTokenDataType do
  use Ecto.Migration

  def change do
		alter table(:users) do
		  modify :tokenBalance, :bigint
		end
  end
end
