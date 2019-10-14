defmodule ToDoListWeb.Acceptance.UserHistory02Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  describe "US02 - User's favorite to-do lists" do
    test "show favorite tasks", %{session: session} do
      user = create_user()
      insert(:favorite, user: user)
      insert(:favorite, user: user)
      insert(:favorite, user: user)
      insert(:favorite, user: user)

      session
      |> sign_in(user)
      |> wait_has(link("Favorites"))
      |> click(link("Favorites"))
      |> find(css(".task-card", count: 4))
    end
  end
end
