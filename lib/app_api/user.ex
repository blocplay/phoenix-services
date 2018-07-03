defmodule AppApi.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias AppApi.{Conversation, Cart, Session}


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :avatar, :map
    field :language, :string
    field :motto, :string
    field :status, :map
    field :email, :string
    field :ewallet, :string
    field :blockchain_token, :string
    field :tokenBalance, :string
    field :password_hash, :string

    has_many :friendships, AppApi.Friendship, foreign_key: :from_user_id
    has_many :friends, through: [:friendships, :to_user]

    has_many :reverse_friendships, AppApi.Friendship, foreign_key: :to_user_id
    has_many :reverse_friends, through: [:reverse_friendships, :from_user]

    many_to_many :conversations, Conversation, join_through: "users_conversations"
    has_many :conversations_owned, Conversation, foreign_key: :creator_id

    belongs_to :current_cart, Cart
    has_many :carts, Cart, foreign_key: :owner_id

    has_many :sessions, Session

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :avatar, :motto, :status, :language, :tokenBalance, :password_hash, :blockchain_token, :ewallet, :current_cart_id])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> cast_assoc(:current_cart, required: false)
  end

  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from user in query,
    where: ilike(user.email, ^wildcard_search)
  end  
end
