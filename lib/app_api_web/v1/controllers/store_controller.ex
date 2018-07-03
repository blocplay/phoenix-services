defmodule AppApiWeb.V1.StoreController do
  use AppApiWeb, :controller
  alias AppApi.{GameFetcher, Repo}
  alias AppApiWeb.V1.JSON.{GameSerializer, ResponseSerializer}

  def front_page(conn, _) do
    json conn, ResponseSerializer.serialize(%{
        id: "e76fc",
        name: "",
        featuredGames: [
          GameSerializer.serialize(GameFetcher.get_by_name("Heavy Gear Assault")),
          GameSerializer.serialize(GameFetcher.get_by_name("Jennifer Wilde")),
          GameSerializer.serialize(GameFetcher.get_by_name("Galaxy of Pen and Paper"))          
        ],
        sections: [ 
          %{
            id: "e76fd",
            title: "Latest games",
            games: [
              GameSerializer.serialize(GameFetcher.get_by_name("Mutant Football League")),
              GameSerializer.serialize(GameFetcher.get_by_name("A Duel Hand Disaster: Trackher")),
              GameSerializer.serialize(GameFetcher.get_by_name("Heavy Gear Assault")),
              GameSerializer.serialize(GameFetcher.get_by_name("Chroma Squad")),
            ]
          },
          %{
            id: "e76fe",
            title: "Latest content",
            games: [
              GameSerializer.serialize(GameFetcher.get_by_name("Jennifer Wilde")),
              GameSerializer.serialize(GameFetcher.get_by_name("Wailing Heights")),
              GameSerializer.serialize(GameFetcher.get_by_name("Heavy Gear Assault")),
              GameSerializer.serialize(GameFetcher.get_by_name("A Duel Hand Disaster: Trackher")),
            ]
          }
        ],
        platformCategories: [
          %{
            "platform": "ios",
            "categories": [
              %{ "id": "875a", "name": "Action Games"},
              %{ "id": "875b", "name": "Mobile Games"},
              %{ "id": "875c", "name": "FP2 Games"},
            ]
          },
          %{
            "platform": "android",
            "categories": [
              %{ "id": "875f", "name": "FP2 Games"},
              %{ "id": "875e", "name": "Mobile Games"},
              %{ "id": "875d", "name": "Action Games"},
            ]
          },
          %{
            "platform": "pc",
            "categories": [
              %{ "id": "875h", "name": "Mobile Games"},
              %{ "id": "875g", "name": "Action Games"},
              %{ "id": "875i", "name": "FP2 Games"},
            ]
          },
        ]
            
      } , "ok")
  end


end
