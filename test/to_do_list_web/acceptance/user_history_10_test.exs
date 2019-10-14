defmodule ToDoListWeb.Acceptance.UserHistory10Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    [user: user]
  end

  describe "US10 - Create to-do list" do
    test "create new task", %{session: session, user: user} do
      session
      |> sign_in(user)
      |> visit("/my-to-do-lists")
      |> refute_has(css(".task-card"))
      |> click(button("Create New"))
      |> wait_has(css("#task-create-form"))
      |> find(css("#task-create-form"))
      |> fill_in(text_field("title"), with: "New task")
      |> click(button("Create"))
    end
  end
end
