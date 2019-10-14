defmodule ToDoListWeb.TaskItemView do
  use ToDoListWeb, :view
  alias ToDoListWeb.TaskItemView

  def render("index.json", %{task_items: task_items}) do
    %{data: render_many(task_items, TaskItemView, "task_item.json")}
  end

  def render("show.json", %{task_item: task_item}) do
    %{data: render_one(task_item, TaskItemView, "task_item.json")}
  end

  def render("task_item.json", %{task_item: task_item}) do
    %{id: task_item.id, title: task_item.title, done: task_item.done}
  end
end
