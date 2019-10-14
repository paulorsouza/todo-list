defmodule ToDoListWeb.UsersController do
  use ToDoListWeb, :controller

  alias ToDoList.User
  alias ToDoList.User.Users

  def index(conn, _params) do
    user = User.list_user()
    render(conn, "index.html", user: user)
  end

  def new(conn, _params) do
    changeset = User.change_users(%Users{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"users" => users_params}) do
    case User.create_users(users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users created successfully.")
        |> redirect(to: Routes.users_path(conn, :show, users))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    users = User.get_users!(id)
    render(conn, "show.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    users = User.get_users!(id)
    changeset = User.change_users(users)
    render(conn, "edit.html", users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = User.get_users!(id)

    case User.update_users(users, users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users updated successfully.")
        |> redirect(to: Routes.users_path(conn, :show, users))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", users: users, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = User.get_users!(id)
    {:ok, _users} = User.delete_users(users)

    conn
    |> put_flash(:info, "Users deleted successfully.")
    |> redirect(to: Routes.users_path(conn, :index))
  end
end
