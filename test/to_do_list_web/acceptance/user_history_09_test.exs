defmodule ToDoListWeb.Acceptance.UserHistory09Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    user2 = insert(:user)
    task = insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: true)
    insert(:task, public: true, user: user2)
    insert(:task, public: true, user: user2)
    insert(:task, public: true, user: user2)
    [user: user, task: task, another_user: user2]
  end

  describe "US09 - Favorite to-do list" do
    test "in recente tasks page", %{session: session, user: user} do
      session
      |> sign_in(user)
      |> visit("/recent-lists")
      |> wait_has(css(".task-card", count: 6))
      |> find(css(".task-card", count: 6))
      |> List.first()
      |> wait_has(css(".far.fa-star"))
      |> click(css(".far.fa-star"))
      |> wait_has(css(".fas.fa-star"))
    end

    test "in edit task page", %{session: session, user: user, task: task} do
      session
      |> sign_in(user)
      |> visit("/task/#{task.id}")
      |> wait_has(Query.text(task.title))
      |> wait_has(css(".far.fa-star"))
      |> click(css(".far.fa-star"))
      |> wait_has(css(".fas.fa-star"))
    end

    test "in user profile", %{session: session, user: user, another_user: another_user} do
      session
      |> sign_in(user)
      |> visit("/user/#{another_user.username}/profile")
      |> wait_has(css(".task-card", count: 3))
      |> find(css(".task-card", count: 3))
      |> List.first()
      |> wait_has(css(".far.fa-star"))
      |> click(css(".far.fa-star"))
      |> wait_has(css(".fas.fa-star"))
    end
  end
end
