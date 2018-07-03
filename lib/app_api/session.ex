defmodule AppApi.Session do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.User


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sessions" do
    field :auth_token, :string
    field :auth_token_hash, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:auth_token, :auth_token_hash, :user_id])
    |> validate_required([:auth_token, :auth_token_hash])
    |> cast_assoc(:user, required: false)
  end
end
