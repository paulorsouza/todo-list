defmodule ToDoListWeb.RecentTaskController do
  use ToDoListWeb, :controller

  alias ToDoList.ToDoLists

  action_fallback ToDoListWeb.FallbackController

  def index(%{assigns: %{current_user: user}} = conn, _params) do
    tasks = ToDoLists.list_public_tasks(user.id)

    conn
    |> put_view(ToDoListWeb.TaskView)
    |> render("index.json", tasks: tasks)
  end
end
