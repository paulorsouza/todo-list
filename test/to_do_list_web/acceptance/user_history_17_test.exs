defmodule ToDoListWeb.Acceptance.UserHistory17Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: false)
    [user: user]
  end

  describe "US17 - Public to-do lists page" do
    test "view all public tasks", %{session: session, user: user} do
      session
      |> sign_in(user)
      |> visit("/recent-lists")
      |> wait_has(css(".task-card", count: 5))
    end
  end
end
