defmodule ToDoListWeb.Acceptance.UserHistory01Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  describe "US01 - User Sign In" do
    test "with valid credentials", %{session: session} do
      sign_in(session)
    end

    test "with invalid credentials", %{session: session} do
      session
      |> visit("/sign-in")
      |> find(css("#sign-in-form"), fn form ->
        form
        |> fill_in(text_field("credential"), with: "teste")
        |> fill_in(text_field("password"), with: "teste")
        |> click(button("Sign In!"))
      end)

      find(session, css(".page-error", count: 1))
    end
  end
end
