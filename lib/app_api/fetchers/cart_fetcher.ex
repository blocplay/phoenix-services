defmodule AppApi.CartFetcher do
  @moduledoc """
  Handles the retrieval and formatting of users from the local storage.
  """
  alias AppApi.{User, Repo, Game, Cart, GameFetcher, CartItem, Blockchain}
  require Logger

  def get(id) do
    Cart |> Repo.get(id)
  end

  def all() do
    Cart |> Repo.all
  end

  def all(%User{} = user) do
    user = user |> Repo.preload(:carts)
    user.carts
  end

  def get_or_set_current_cart(%User{} = user) do
    user_with_cart = user |> Repo.preload(:current_cart)
    case user_with_cart.current_cart_id do
      nil -> 
        user_changeset = Ecto.build_assoc(user_with_cart, :current_cart, %{owner_id: user_with_cart.id, status: "open"})
        case Repo.insert(user_changeset) do
          {:ok, cart} -> 
            user_with_cart = user_with_cart |> User.changeset(%{current_cart_id: cart.id}) |> Repo.update()
            user_with_cart
          err -> err
        end
      cart -> user_with_cart.current_cart
    end
  end

  def reset_current_cart(%User{} = user) do
    user_with_cart = user |> Repo.preload(:current_cart)
    user_changeset = Ecto.build_assoc(user_with_cart, :current_cart, %{owner_id: user_with_cart.id, status: "open"})
    case Repo.insert(user_changeset) do
      {:ok, cart} -> 
        user_with_cart |> User.changeset(%{current_cart_id: cart.id}) |> Repo.update()
        user_with_cart = user_with_cart |> Repo.preload(:current_cart)
        user_with_cart
      err -> err
    end
  end

  def add(%User{} = user, game_id) do
    # lets make sure we've got a cart for this user and the game exists
    # @TODO: if game in cart already, reject?
    with cart <- get_or_set_current_cart(user),
      %Game{} = game <- Game |> Repo.get(game_id),
      %Cart{} = cart <- cart |> Repo.preload(:cart_items)
    do
      %CartItem{}
        |> CartItem.changeset(%{game_id: game.id, cart_id: cart.id, qty: 1})
        |> Repo.insert()
    else
      err -> %{description: "Failed to add to cart"}
    end
  end

  def remove(%CartItem{} = cart_item) do
    Repo.delete(cart_item)
  end


  def buy(%User{} = user) do
    with cart <- get_or_set_current_cart(user),
      cart <- cart |> Repo.preload(:cart_items),
      result <- cart.cart_items |> Enum.map(fn(item) -> 
        item = item |> Repo.preload(:game)
        case Blockchain.buyGame(%{token: user.blockchain_token, game_id: item.game.blockchain_id}) do
          %{"result" => %{"pendingToken" => %{"_id" => _}}} ->
            Logger.debug "bought game: #{item.game.blockchain_id}" 
            remove(item)
            true 
          {:error, %{reason: :timeout}} ->
            "Blockchain API timed out"
          {:error, error} ->
            error.reason
          err -> 
            Logger.debug "failed to buy game: #{item.game.blockchain_id}"
            Logger.debug inspect err
            err["error"]["message"]   
        end
      end )
    do
      result
    end
  end

end
