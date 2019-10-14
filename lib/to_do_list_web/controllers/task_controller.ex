defmodule ToDoListWeb.TaskController do
  use ToDoListWeb, :controller

  alias ToDoList.Accounts
  alias ToDoList.ToDoLists
  alias ToDoList.ToDoLists.Task

  action_fallback ToDoListWeb.FallbackController

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns[:current_user]]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, _user) do
    tasks = ToDoLists.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => payload}, user) do
    task_params = Map.put(payload, "owner", user.id)

    with {:ok, %Task{} = task} <- ToDoLists.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => task_id}, current_user) do
    case ToDoLists.get_task(task_id, current_user.id) do
      nil ->
        {:error, :not_found}

      task ->
        is_favorite = Accounts.favorite?(task.id, current_user.id)
        params = %{task: task, current_user: current_user, is_favorite: is_favorite}
        render(conn, "show.json", params)
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}, _user) do
    task = ToDoLists.get_task!(id)

    with {:ok, %Task{} = task} <- ToDoLists.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    task = ToDoLists.get_task!(id)

    with {:ok, %Task{}} <- ToDoLists.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
