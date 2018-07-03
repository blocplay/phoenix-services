defmodule AppApi.Repo.Migrations.RemoveUnusedFieledsFromGames do
  use Ecto.Migration

  def change do
		alter table("games") do
		  remove :publisher
		  remove :media_activity
		  remove :media_cover
		  remove :media_store
		end
  end
end
