defmodule AppApi.Repo.Migrations.AddMetadataToGames do
  use Ecto.Migration

  def change do
		alter table(:games) do
		  add :metadata, :map
		end
  end
end
