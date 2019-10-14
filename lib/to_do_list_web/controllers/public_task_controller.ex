defmodule ToDoListWeb.PublicTaskController do
  use ToDoListWeb, :controller

  alias ToDoList.ToDoLists

  action_fallback ToDoListWeb.FallbackController

  def index(conn, _params) do
    tasks = ToDoLists.list_public_tasks()

    conn
    |> put_view(ToDoListWeb.TaskView)
    |> render("index.json", tasks: tasks)
  end
end
