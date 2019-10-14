defmodule ToDoListWeb.Acceptance.UserHistory04Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    task = insert(:task, user: user)
    insert(:task_item, title: "teste 1", task: task)
    [user: user, task: task]
  end

  describe "US04 - Mark as done/undone" do
    test "click on checkbox done/undone task", %{session: session, user: user, task: task} do
      session
      |> sign_in(user)
      |> visit("/task/#{task.id}")
      |> wait_has(Query.text(task.title))
      |> wait_has(css(".task-item"))
      |> click(css(".checkmark"))
      |> wait_has(css(".done"))
      |> click(css(".checkmark"))
      |> refute_has(css(".done"))
    end
  end
end
