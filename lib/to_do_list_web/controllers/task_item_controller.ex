defmodule ToDoListWeb.TaskItemController do
  use ToDoListWeb, :controller

  alias ToDoList.ToDoLists
  alias ToDoList.ToDoLists.TaskItem

  action_fallback ToDoListWeb.FallbackController

  def index(conn, _params) do
    task_items = ToDoLists.list_task_items()
    render(conn, "index.json", task_items: task_items)
  end

  def create(conn, %{"task_item" => task_item_params, "task_id" => task_id}) do
    with {:ok, %TaskItem{} = task_item} <- ToDoLists.create_task_item(task_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.task_task_item_path(conn, :show, task_id, task_item.id)
      )
      |> render("show.json", task_item: task_item)
    end
  end

  def show(conn, %{"id" => id}) do
    task_item = ToDoLists.get_task_item!(id)
    render(conn, "show.json", task_item: task_item)
  end

  def update(conn, %{"id" => id, "task_item" => task_item_params}) do
    task_item = ToDoLists.get_task_item!(id)

    with {:ok, %TaskItem{} = task_item} <- ToDoLists.update_task_item(task_item, task_item_params) do
      render(conn, "show.json", task_item: task_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    task_item = ToDoLists.get_task_item!(id)

    with {:ok, %TaskItem{}} <- ToDoLists.delete_task_item(task_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
