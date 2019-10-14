defmodule ToDoListWeb.Acceptance.UserHistory13Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    another_user = insert(:user)
    insert(:task, public: true, user: user)
    insert(:task, public: true, user: user)
    insert(:task, public: true, user: user)
    insert(:task, public: false, user: user)
    insert(:task, public: true, user: another_user)
    insert(:task, public: true, user: another_user)
    insert(:task, public: true, user: another_user)
    insert(:task, public: false, user: another_user)
    [user: user, another_user: another_user]
  end

  describe "US13 - User's profile page" do
    test "view only public in another user profile", %{
      session: session,
      user: user,
      another_user: another_user
    } do
      session
      |> sign_in(user)
      |> visit("/user/#{another_user.username}/profile")
      |> wait_has(css(".task-card", count: 3))
    end
  end

  test "view public and private in current user profile", %{session: session, user: user} do
    session
    |> sign_in(user)
    |> visit("/user/#{user.username}/profile")
    |> wait_has(css(".task-card", count: 4))
  end
end
