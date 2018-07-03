defmodule AppApi.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.{Game, User, CartItem, Repo}


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "carts" do
    field :status, :string

    belongs_to :user, User, foreign_key: :owner_id
    has_many :cart_items, CartItem

    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end

  def total(cart) do
    cart = cart |> Repo.preload(:cart_items)
    cart.cart_items |> Enum.map(fn(item) -> CartItem.price(item) end) |> Enum.sum()
  end

end
