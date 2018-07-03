defmodule AppApi.Repo.Migrations.RemoveTokensFromUser do
  use Ecto.Migration

  def change do
		alter table("users") do
		  remove :auth_token
		  remove :auth_token_hash
		end
  end
end
