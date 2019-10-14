defmodule ToDoListWeb.Acceptance.UserHistory03Test do
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

  describe "US03 - Edit tasks" do
    test "click out dont save new title", %{session: session, user: user, task: task} do
      session
      |> sign_in(user)
      |> visit("/task/#{task.id}")
      |> wait_has(Query.text(task.title))
      |> wait_has(css(".task-item"))
      |> click(css(".task-item-title"))
      |> fill_in(css(".new-title-input"), with: "new title")
      |> click(css(".form-header"))
      |> find(Query.text("teste 1"))
    end
  end

  test "press enter save new title", %{session: session, user: user, task: task} do
    session
    |> sign_in(user)
    |> visit("/task/#{task.id}")
    |> wait_has(Query.text(task.title))
    |> wait_has(css(".task-item"))
    |> click(css(".task-item-title"))
    |> fill_in(css(".new-title-input"), with: "new title")
    |> send_keys([:enter])
    |> find(Query.text("new title"))
  end
end
