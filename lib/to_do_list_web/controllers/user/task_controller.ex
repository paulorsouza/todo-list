defmodule ToDoListWeb.User.TaskController do
  use ToDoListWeb, :controller

  alias ToDoList.Accounts

  action_fallback ToDoListWeb.FallbackController

  def index(%{assigns: %{current_user: user}} = conn, _) do
    tasks = Accounts.get_user_tasks!(user.id)

    conn
    |> put_view(ToDoListWeb.TaskView)
    |> render("index.json", tasks: tasks)
  end
end
