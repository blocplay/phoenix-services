defmodule AppApi.ConversationMessageEventFetcher do
  @moduledoc """
  Handles the retrieval and formatting of users from the local storage.
  """
  alias AppApi.{User, Repo, Conversation, ConversationMessage}
  alias AppApi.ConversationMessageEvent, as: CME
  import Ecto.Query
  require Logger

  def get(id) do
  	CME |> Repo.get(id)
  end

end
