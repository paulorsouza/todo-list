defmodule ToDoListWeb.Acceptance.UserHistory08Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  setup do
    user = create_user()
    [user: user]
  end

  @link link("I forgot my password")
  @form css("#recover-account-form")
  @success css(".success")
  @error css(".error")

  describe "US08 - Recover user account" do
    test "with valid credential", %{session: session, user: user} do
      session
      |> visit("/sign-in")
      |> wait_has(@link)
      |> click(@link)
      |> wait_has(@form)
      |> find(@form, fn form ->
        form
        |> fill_in(text_field("credential"), with: user.username)
        |> click(button("Recover!"))
        |> wait_has(@success)
      end)
    end

    test "with invalid credential", %{session: session} do
      session
      |> visit("/sign-in")
      |> wait_has(@link)
      |> click(@link)
      |> wait_has(@form)
      |> find(@form, fn form ->
        form
        |> fill_in(text_field("credential"), with: "invalid-user")
        |> click(button("Recover!"))
        |> wait_has(@error)
      end)
    end
  end
end
