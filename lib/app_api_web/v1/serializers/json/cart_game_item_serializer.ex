defmodule AppApiWeb.V1.JSON.CartGameItemSerializer do
  alias AppApi.{Cart, CartItem, Convert, Game, Repo}
  alias AppApiWeb.V1.JSON.GameSerializer
  require Logger
  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(%CartItem{} = c) when not is_nil(c) do
    c = c |> Repo.preload(:game)
    %{
      id: c.id,
      type: "game",
      game: GameSerializer.serialize(c.game)
    }
  end
  def serialize() do %{} end


end
