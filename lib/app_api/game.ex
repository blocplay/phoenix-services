defmodule AppApi.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.{Cart, CartItem}


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "games" do
    field :blockchain_id, :integer
    field :price, :string
    field :name, :string
    field :description, :string
    field :metadata, :map

    has_many :cart_items, CartItem, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:blockchain_id, :price, :name, :metadata, :description])
    |> validate_required([:blockchain_id, :price, :name, :metadata])
  end
end
