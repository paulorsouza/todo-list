defmodule ToDoListWeb.Acceptance.UserHistory12Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    task = insert(:task, public: true)
    insert(:task_item, title: "item 1", task: task)
    insert(:task_item, title: "item 2", task: task)
    insert(:task_item, title: "item 3", task: task)
    [user: user, task: task]
  end

  describe "US12 - View to-do lists" do
    test "click on task to view task items", %{session: session, user: user} do
      session
      |> sign_in(user)
      |> visit("/recent-lists")
      |> wait_has(css(".task-card"))
      |> click(css(".task-card"))
      |> find(css("li", count: 3))
    end
  end
end
