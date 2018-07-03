defmodule AppApi.Repo.Migrations.AddEwalletToUsers do
  use Ecto.Migration

  def change do
		alter table(:users) do
		  add :ewallet, :string
		end
  end
end
