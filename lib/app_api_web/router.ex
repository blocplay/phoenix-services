defmodule AppApiWeb.Router do
  use AppApiWeb, :router
  alias AppApiWeb.StatusController
  alias AppApiWeb.V1.Plug.{Auth, FakeUpdateAuth}

  pipeline :auth do
    plug Auth
  end

  pipeline :fake_auth do
    plug FakeUpdateAuth
  end

  scope "/api" do
    # api status endpoints
    get "/", StatusController, :status
    # API v1.0.0
    scope "/1.0.0" do
      alias AppApiWeb.V1.{StatusController, AuthController, UserController, FriendshipController, ConversationController, GameController, CartController, StoreController}

      # API status endpoints
	    post "/status", StatusController, :index
	    post "/status.server_error", StatusController, :server_error

      # auth endpoints
	    post "/auth.login", AuthController, :login
	    post "/auth.logout", AuthController, :logout

      # users endpoints
      post "/users.signup", AuthController, :signup

      # public games endpoints
      post "/games.getAll", GameController, :getAll
      post "/games.get/:game_ids", GameController, :get

      scope "/" do
        pipe_through [:fake_auth]
        post "/games.update/:id", GameController, :update
      end

      scope "/" do
        pipe_through [:auth]

        # users
        post "/users.get/:user_ids", UserController, :get
        post "/users.me", UserController, :me
        post "/users.search", UserController, :search
        post "/users.admin.all", UserController, :all

        # friendships
        post "/friends.invite/:user_ids", FriendshipController, :invite
        post "/friends.getAll", FriendshipController, :getAll
        post "/friends.remove/:user_id", FriendshipController, :remove
        post "/friendRequests.getAll", FriendshipController, :getRequests
        post "/friendRequests.approve/:request_ids", FriendshipController, :approve
        post "/friendRequests.reject/:request_ids", FriendshipController, :reject

        # conversations
        post "/conversations.create", ConversationController, :create
        post "/conversations.getAll", ConversationController, :getAll
        post "/conversations.get/:conversation_id", ConversationController, :get
        post "/conversations.delete/:conversation_id", ConversationController, :delete

        # cart
        post "/cart.get", CartController, :get
        post "/cart.add", CartController, :add
        post "/cart.remove/:cart_item_id", CartController, :remove
        post "/cart.buy", CartController, :buy

        # games
        post "/userGames.getAll", GameController, :getMine

        # store
        post "/store.getFrontPage", StoreController, :front_page


      end 

      # all else..
      match :*, "/*path", FallbackController, :not_found
    end
  end
end
