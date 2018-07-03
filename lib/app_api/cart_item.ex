defmodule AppApi.CartItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.{Game, Cart, Repo}


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cart_items" do
    field :qty, :integer

    belongs_to :game, Game
    belongs_to :cart, Cart

    timestamps()
  end

  @doc false
  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, [:qty, :cart_id, :game_id])
    |> validate_required([:qty])
    |> cast_assoc(:game, required: false)
    |> cast_assoc(:cart, required: false)
  end

  def price(cart_item) do
    cart_item = cart_item |> Repo.preload(:game)
    cart_item.game.price    
  end

end
