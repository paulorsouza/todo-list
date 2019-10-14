defmodule ToDoListWeb.TaskView do
  use ToDoListWeb, :view
  alias ToDoListWeb.TaskView
  alias ToDoListWeb.TaskItemView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task, current_user: current_user, is_favorite: is_favorite}) do
    read_only = current_user.id != task.owner

    %{
      data: render_one(task, TaskView, "task.json"),
      read_only: read_only,
      is_favorite: is_favorite
    }
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: %{user: %{username: username}} = task}) do
    %{
      id: task.id,
      title: task.title,
      public: task.public,
      owner_name: username,
      task_items: render_many(task.task_items, TaskItemView, "task_item.json"),
      updated_at: task.updated_at,
      inserted_at: task.inserted_at,
      is_favorite: task.is_favorite
    }
  end

  def render("task.json", %{task: task}) do
    %{id: task.id, title: task.title, public: task.public}
  end
end
