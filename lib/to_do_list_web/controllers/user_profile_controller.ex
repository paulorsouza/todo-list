defmodule ToDoListWeb.UserProfileController do
  use ToDoListWeb, :controller

  alias ToDoList.Accounts
  alias ToDoList.ToDoLists

  action_fallback ToDoListWeb.FallbackController

  def show(%{assigns: %{current_user: current_user}} = conn, %{"username" => username}) do
    tasks =
      username
      |> Accounts.get_user_by_name!()
      |> ToDoLists.list_user_tasks(favorited_by: current_user)

    conn
    |> put_view(ToDoListWeb.TaskView)
    |> render("index.json", tasks: tasks)
  end
end
