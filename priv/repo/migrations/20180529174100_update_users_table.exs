defmodule AppApi.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
		alter table(:users) do
		  add :metadata, :map
		end

  end
end
