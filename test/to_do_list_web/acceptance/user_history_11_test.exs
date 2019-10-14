defmodule ToDoListWeb.Acceptance.UserHistory11Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    task = insert(:task, user: user)
    [user: user, task: task]
  end

  describe "US11 - Remove todo-list" do
    test "delete task", %{session: session, user: user, task: task} do
      session
      |> sign_in(user)
      |> visit("/task/#{task.id}")
      |> wait_has(Query.text(task.title))
      |> click(button("Delete List"))
      |> wait_has(button("Confirm"))
      |> refute_has(css(".task-card"))
    end
  end
end
