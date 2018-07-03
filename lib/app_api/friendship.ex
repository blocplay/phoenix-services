defmodule AppApi.Friendship do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "friendships" do
    field :status, :boolean, default: false

    belongs_to :from_user, AppApi.User
    belongs_to :to_user, AppApi.User

    timestamps()
  end

  @doc false
  def changeset(friendship, attrs) do
    friendship
    |> cast(attrs, [:status, :from_user_id, :to_user_id])
    |> validate_required([:status])
    |> cast_assoc(:from_user, required: false)
    |> cast_assoc(:to_user, required: false)
    |> unique_constraint(:from_user_id, name: :friendships_from_user_id_to_user_id_index)
  end

  # @TODO: validations when creating a new friendship:
  # 1. is there a relationship between both already? 
  # 2. if there's one and it's reverse this one and it's not approved, then approve it?
  # 3. more?

end
