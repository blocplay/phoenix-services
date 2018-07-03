defmodule AppApiWeb.V1.CartController do
  use AppApiWeb, :controller
  alias AppApi.{Cart, CartFetcher, CartItem, Repo}
  alias AppApiWeb.V1.JSON.{CartSerializer, ResponseSerializer, CartGameItemSerializer}
  require Logger

  def get(conn, params) do
    case CartFetcher.get_or_set_current_cart(conn.assigns[:user]) do
      %Cart{} = cart -> json conn, ResponseSerializer.serialize(CartSerializer.serialize(cart), "ok")
      err ->json conn, ResponseSerializer.serialize(err, "error")    
    end
  end

  def add(conn, %{"type" => "game", "game" => %{"id" => game_id}}) do
    case CartFetcher.add(conn.assigns[:user], game_id) do
      {:ok, cart_item} -> json conn, ResponseSerializer.serialize(CartGameItemSerializer.serialize(cart_item), "ok")
      err ->json conn, ResponseSerializer.serialize(err, "error")    
    end
  end

  def remove(conn, params) do
    case CartItem |> Repo.get(params["cart_item_id"]) do
      %CartItem{} = cart_item -> 
        case CartFetcher.remove(cart_item) do
          {:ok, _} -> json conn, ResponseSerializer.serialize(%{}, "ok")    
          err -> json conn, ResponseSerializer.serialize(err, "error")    
        end
      err ->json conn, ResponseSerializer.serialize(err, "error")    
    end    
  end

  def buy(conn, _attrs) do
    # check cart total price and available tokens
    # should refresh user tokens before returning?
    result = CartFetcher.buy(conn.assigns[:user])
    case Enum.find(result, fn(res) -> res != true end) do
      nil -> json conn, ResponseSerializer.serialize(%{}, "ok")   
      err -> json conn, ResponseSerializer.serialize(err, "error")    
    end
    
  end


end
