defmodule ToDoList.Guardian do
  @moduledoc """
  Utilities to get info from guardian
  """

  use Guardian, otp_app: :to_do_list
  alias ToDoList.Accounts.User

  def subject_for_token(%User{} = user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, "Unknown resource type"}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = ToDoList.Accounts.get_user!(id)
    {:ok, resource}
  end
end
