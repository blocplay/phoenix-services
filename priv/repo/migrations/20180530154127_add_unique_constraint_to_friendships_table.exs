defmodule AppApi.Repo.Migrations.AddUniqueConstraintToFriendshipsTable do
  use Ecto.Migration

  def change do
		create unique_index(:friendships, [:from_user_id, :to_user_id])
  end
end
