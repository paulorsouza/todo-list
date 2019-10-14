defmodule ToDoListWeb.Acceptance.UserHistory06Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: false)
    []
  end

  @link link("user's public lists")

  describe "US06 - Landing Page" do
    test "click on item and click on remove button", %{session: session} do
      session
      |> visit("/")
      |> wait_has(@link)
      |> click(@link)
      |> find(css(".task-card", count: 3))
    end
  end
end
