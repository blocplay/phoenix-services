defmodule AppApiWeb.ConversationChannelTest do
	use AppApiWeb.ChannelCase
	alias AppApiWeb.{ConversationChannel, UserSocket}
	alias AppApi.{User, Conversation, Repo, ConversationFetcher, SessionFetcher, ConversationMessageEvent, ConversationMessage, Session}
	require Logger
	import Ecto.Query

	def user_group_1 do
		[
			%{
				email: "testuser1@example.com"
			},
			%{
				email: "admin_branch3@example.com"
			}
		]		
	end

	def user_group_2 do
		[
			%{
				email: "admin_branch1@example.com"
			},
			%{
				email: "admin_branch2@example.com"
			}
		]		
	end

	def get_user_token_hash(%User{} = user) do
		"bG9jYWwxQGV4YW1wbGUuY29tOkVsNThkS3Y5Sk9YbFVVTVRFcHl3eHpob2hpaG5hQXBGVkxLZEJxNFZCRUU"
	end

	test "user can't connect to socket if not authenticated" do
		{user, conversation} = create_sample_room_with_users()
		:error = connect(UserSocket, %{token: "WRONG_TOKEN"})
	end

	test "user can connect to socket if properly authenticated" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
	end

	test "user sends text message successfully" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		ref = push(socket, "event", %{
			"type" => "message:sent", 
			"message" => %{ 
				"ref"	 => "some_ref_id",
				"content" => "here's a messsage for ya!" ,
				"type"		=> "text"
				}
			})
	  assert_reply ref, :ok
	  assert_broadcast("event", %{type: "message:sent", id: new_msg_event_id})
	  assert_push "event", %{"type" => "message:updated", "ref" => "some_ref_id"}
	  assert Repo.get_by(ConversationMessageEvent, id: new_msg_event_id)
	end

	test "user updates text message successfully" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		{:ok, cme} = create_message(conversation, user, %{"type" => "text", "content" => "about to change"})
		message = cme.message
		original_message_id = message.id
		ref = push(socket, "event", %{
			"type" => "message:updated", 
			"message" => %{ 
				"id" => original_message_id,
				"content" => "it worked!",
				"type" => "text"
				}
			})
	  # @TODO check the message got updated on the channel and on the DB
	  assert_broadcast("event", %{type: "message:updated", message: %{content: "it worked!"}})
	  assert Repo.get_by(ConversationMessage, id: original_message_id, content: "it worked!")
	end

	test "user deletes text message successfully" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		{:ok, cme} = create_message(conversation, user, %{"type" => "text", "content" => "about to delete"})
		message = cme.message
		original_message_id = message.id
		ref = push(socket, "event", %{
			"type" => "message:deleted", 
			"message" => %{ 
				"id" => original_message_id
				}
			})
	  # @TODO check the message got updated on the channel and on the DB
	  assert_broadcast("event", %{"type" => "message:deleted", "message" => %{"id" => original_message_id}})
	  refute Repo.get_by(ConversationMessage, id: original_message_id)
	end

	test "user is added to conversation" do
		{user, conversation} = create_sample_room_with_users()
		additional_users = seed_users(user_group_2())
		user1 = User |> Repo.get_by(email: "admin_branch1@example.com")
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		socket 
			|> push("event", %{ "type" => "user:joined", "userId" => user1.id } )
	  assert_broadcast("event", %{"type" => "user:joined"})
	  assert ConversationFetcher.get(user1, conversation.id)
	end

	test "user is removed from conversation" do
		{user, conversation} = create_sample_room_with_users()
		additional_users = seed_users(user_group_2())
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		user1 = User |> Repo.get_by(email: "admin_branch3@example.com")
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		socket 
			|> push("event", %{ "type" => "user:left", "userId" => user.id } )
	  assert_broadcast("event", %{"type" => "user:left"})
	  refute ConversationFetcher.get(user, conversation.id)
	  assert ConversationFetcher.get(user1, conversation.id)
	end

	test "user starts typing" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		socket 
			|> push("event", %{ "type" => "user:typingStarted" } )
	  assert_broadcast("event", %{"type" => "user:typingStarted"})
	end

	test "user stops typing" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		socket 
			|> push("event", %{ "type" => "user:typingStopped" } )
	  assert_broadcast("event", %{"type" => "user:typingStopped"})
	end

	test "user enters conversation" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		socket 
			|> push("event", %{ "type" => "user:entered" } )
	  assert_broadcast("event", %{"type" => "user:entered"})
	end

	test "user exits conversation" do
		{user, conversation} = create_sample_room_with_users()
		{:ok, socket} = connect(UserSocket, %{token: get_user_token_hash(user)})
		{:ok, _, socket} = subscribe_and_join(socket, "conversation.socket/#{conversation.id}")
		socket 
			|> push("event", %{ "type" => "user:exited" } )
	  assert_broadcast("event", %{"type" => "user:exited"})
	end

	def create_sample_room_with_users() do
	  seed_users(user_group_1())
	  user1 = User |> Repo.get_by(email: "testuser1@example.com")
	  seed_sessions(user1)
	  seed_conversations(user1)
	  conversation = Conversation |> Repo.all() |> List.first()
		{user1, conversation}		
	end

	def seed_sessions(%User{} = user) do
		SessionFetcher.create(%{user_id: user.id, auth_token: "REALTOKENHERE", auth_token_hash: "bG9jYWwxQGV4YW1wbGUuY29tOkVsNThkS3Y5Sk9YbFVVTVRFcHl3eHpob2hpaG5hQXBGVkxLZEJxNFZCRUU"})
	end

	def create_user(%{} = user_info) do
	  %User{}
	  |> User.changeset(user_info)
	  |> Repo.insert
	end

	def seed_users(users) do
		Enum.each(users, fn(user) -> 
				{:ok, result} = create_user(user) 
			end)
	end

	def create_message(conversation, user, message) do
		ConversationFetcher.create_message_event(conversation, user, message)
	end

	def seed_conversations(user) do
		query = from p in User, select: p.id
		user_ids = User |> Repo.all |> Enum.map(fn(u) -> u.id end)
		Enum.each([
				%{
					title: "convo 1",
					participants: user_ids
				},
				%{
					title: "another convo",
					participants: user_ids
				}
			], fn(conversation) -> 
				result = ConversationFetcher.create(user, conversation) 
			end)
	end


end