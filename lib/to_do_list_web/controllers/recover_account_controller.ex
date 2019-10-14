defmodule ToDoListWeb.RecoverAccountController do
  use ToDoListWeb, :controller

  alias ToDoList.Accounts
  alias ToDoList.Guardian
  alias ToDoList.Mailer
  alias ToDoListWeb.Email

  action_fallback ToDoListWeb.FallbackController

  def create(conn, %{"credential" => credential}) do
    case Accounts.get_user(credential) do
      nil ->
        conn |> put_status(422) |> render("not_found.json", %{})

      user ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)

        user
        |> Email.send_link_with_valid_token(token)
        |> Mailer.deliver_now()

        send_resp(conn, :ok, "")
    end
  end
end
