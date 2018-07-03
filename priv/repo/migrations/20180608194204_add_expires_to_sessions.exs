defmodule AppApi.Repo.Migrations.AddExpiresToSessions do
  use Ecto.Migration

  def change do
		alter table(:sessions) do
		  add :expires_at, :timestamp
		end

  end
end
