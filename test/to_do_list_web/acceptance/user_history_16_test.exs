defmodule ToDoListWeb.Acceptance.UserHistory16Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    task = insert(:task, user: user)
    [user: user, task: task]
  end

  describe "US16 - Add task to list" do
    test "create new item", %{session: session, user: user, task: task} do
      session
      |> sign_in(user)
      |> visit("/task/#{task.id}")
      |> wait_has(css("#task-item-create-form"))
      |> find(css("#task-item-create-form"))
      |> fill_in(text_field("title"), with: "new item")

      session
      |> send_keys([:enter])
      |> wait_has(css(".task-item-title"))
    end
  end
end
