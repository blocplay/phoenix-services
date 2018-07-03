defmodule AppApi.Repo.Migrations.AddDescriptionToGames do
  use Ecto.Migration

  def change do
		alter table(:games) do
		  add :description, :text
		end
  end
end
