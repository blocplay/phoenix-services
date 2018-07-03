defmodule AppApiWeb.V1.JSON.CartSerializer do
  alias AppApi.{Cart, Convert, Repo}
  alias AppApiWeb.V1.JSON.CartGameItemSerializer
  require Logger
  @moduledoc """
  Serializes data into V1 JSON response format.
  """
  use AppApiWeb.V1

  def serialize(%Cart{} = c) when not is_nil(c) do
    c = c |> Repo.preload(:cart_items)
    %{
      id: c.id,
      items: Enum.map(c.cart_items, fn(item) -> CartGameItemSerializer.serialize(item) end),
    }
  end
  def serialize() do %{} end


end
