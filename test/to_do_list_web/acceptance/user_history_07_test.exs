defmodule ToDoListWeb.Acceptance.UserHistory07Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    [user: user]
  end

  describe "US07 - Edit user's account" do
    test "with valid password", %{session: session, user: user} do
      session
      |> sign_in(user)
      |> wait_has(link("Account"))
      |> click(link("Account"))
      |> find(css("#account-form"), fn form ->
        form
        |> fill_in(text_field("password"), with: "87654321")
        |> fill_in(text_field("confirm"), with: "87654321")
        |> click(button("Update"))
      end)
    end

    test "with invalid password", %{session: session, user: user} do
      session
      |> sign_in(user)
      |> wait_has(link("Account"))
      |> click(link("Account"))
      |> wait_has(css("#account-form"))
      |> find(css("#account-form"), fn form ->
        form
        |> fill_in(text_field("password"), with: "423rewfqfef")
        |> fill_in(text_field("confirm"), with: "fdsafadsfr2")
        |> click(button("Update"))
        |> assert_has(css(".input-error"))
      end)
    end
  end
end
