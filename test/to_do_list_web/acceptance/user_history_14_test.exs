defmodule ToDoListWeb.Acceptance.UserHistory14Test do
  use ToDoListWeb.AcceptanceCase

  import Wallaby.Query
  import Wallaby.Browser

  @moduletag :acceptance

  describe "US14 - User Sign Up" do
    test "with valid fields", %{session: session} do
      session
      |> visit("/sign-up")
      |> wait_has(css("#sign-up-form"))
      |> find(css("#sign-up-form"), fn form ->
        form
        |> fill_in(text_field("username"), with: "teste")
        |> fill_in(text_field("email"), with: "teste@teste.com")
        |> fill_in(text_field("password"), with: "12345678")
        |> fill_in(text_field("confirm"), with: "12345678")
        |> click(button("Sign Up!"))
      end)
    end

    test "with invalid fields", %{session: session} do
      session
      |> visit("/sign-up")
      |> click(button("Sign Up!"))
      |> wait_has(css(".input-error", count: 4))
    end
  end
end
