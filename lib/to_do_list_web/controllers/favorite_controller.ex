defmodule ToDoListWeb.FavoriteController do
  use ToDoListWeb, :controller

  alias ToDoList.Accounts

  action_fallback ToDoListWeb.FallbackController

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns[:current_user]]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _, user) do
    favorites = Accounts.get_user_favorites!(user.id)
    render(conn, "favorite.json", favorites: favorites)
  end

  def create(conn, %{"task_id" => task_id}, user) do
    with {:ok, _favorite} <- Accounts.create_favorite(%{user_id: user.id, task_id: task_id}) do
      send_resp(conn, :created, "")
    end
  end

  def delete(conn, %{"task_id" => task_id}, user) do
    Accounts.delete_favorite(%{user_id: user.id, task_id: task_id})
    send_resp(conn, :no_content, "")
  end
end
