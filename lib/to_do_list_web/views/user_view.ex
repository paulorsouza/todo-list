defmodule ToDoListWeb.UserView do
  use ToDoListWeb, :view
  alias ToDoListWeb.UserView

  def render("not_found.json", _) do
    %{error: "User not found"}
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("token.json", %{token: token, user_id: user_id}) do
    %{token: token, user_id: user_id}
  end

  def render("user.json", %{user: user}) do
    %{username: user.username, email: user.email}
  end
end
