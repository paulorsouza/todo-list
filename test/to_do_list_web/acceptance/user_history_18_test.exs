defmodule ToDoListWeb.Acceptance.UserHistory18Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    [user: user]
  end

  describe "US18 - Highlight the current page" do
    test "change highlight", %{session: session, user: user} do
      session
      |> sign_in(user)
      |> visit("/")
      |> wait_has(link("Account"))
      |> click(link("Account"))
      |> wait_has(css(".nav-links.highlight"))
      |> wait_has(link("Favorites"))
      |> click(link("Favorites"))
      |> wait_has(css(".nav-links.highlight"))
    end
  end
end
