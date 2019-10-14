defmodule ToDoListWeb.Acceptance.UserHistory05Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    task = insert(:task, user: user)
    insert(:task_item, title: "item 1", task: task)
    [user: user, task: task]
  end

  describe "US05 - Remove tasks" do
    test "click on item and click on remove button", %{session: session, user: user, task: task} do
      session
      |> sign_in(user)
      |> visit("/task/#{task.id}")
      |> wait_has(Query.text(task.title))
      |> wait_has(css(".task-item"))
      |> click(css(".task-item-title"))
      |> wait_has(css(".delete-item"))
      |> click(css(".delete-item"))
      |> refute_has(css(".delete-item"))
    end
  end
end
