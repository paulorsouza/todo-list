defmodule ToDoListWeb.UserController do
  use ToDoListWeb, :controller

  alias ToDoList.Accounts
  alias ToDoList.Guardian
  alias ToDoList.Accounts.User

  action_fallback ToDoListWeb.FallbackController

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns[:current_user]]
    apply(__MODULE__, action_name(conn), args)
  end

  def create(conn, %{"user" => user_params}, _user) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("token.json", token: token, user_id: user.id)
    end
  end

  def show(conn, _, user) do
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"user" => user_params}, current_user) do
    user_changes = %{
      email: user_params["email"],
      virtual_password: user_params["virtual_password"],
      virtual_password_confirmation: user_params["virtual_password_confirmation"]
    }

    with {:ok, %User{} = user} <- Accounts.update_user(current_user, user_changes),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "token.json", token: token, user_id: user.id)
    end
  end
end
