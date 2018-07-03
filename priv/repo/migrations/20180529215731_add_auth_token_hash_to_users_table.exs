defmodule AppApi.Repo.Migrations.AddAuthTokenHashToUsersTable do
  use Ecto.Migration

  def change do
		alter table(:users) do
		  add :auth_token_hash, :string
		end
  end
end
