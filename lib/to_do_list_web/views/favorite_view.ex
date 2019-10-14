defmodule ToDoListWeb.FavoriteView do
  use ToDoListWeb, :view
  alias ToDoListWeb.TaskView

  def render("favorite.json", %{favorites: favorites}) do
    %{data: render_many(favorites, TaskView, "task.json")}
  end
end
