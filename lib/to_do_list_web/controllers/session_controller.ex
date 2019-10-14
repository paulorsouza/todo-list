defmodule ToDoListWeb.SessionController do
  use ToDoListWeb, :controller

  alias ToDoList.Accounts

  action_fallback ToDoListWeb.FallbackController

  def create(conn, %{"credential" => credential, "password" => password}) do
    case Accounts.auth_user(credential, password) do
      {:ok, token, claims} ->
        user_id = claims["sub"]

        conn
        |> put_view(ToDoListWeb.UserView)
        |> render("token.json", token: token, user_id: user_id)

      _ ->
        {:error, :unauthorized}
    end
  end
end
