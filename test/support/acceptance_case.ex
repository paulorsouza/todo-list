defmodule ToDoListWeb.AcceptanceCase do
  use ExUnit.CaseTemplate
  import ToDoList.Factory

  import Wallaby.Query
  import Wallaby.Browser

  using do
    quote do
      use Wallaby.DSL

      alias ToDoList.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import ToDoList.Factory
      import ToDoListWeb.AcceptanceCase

      alias ToDoListWeb.Router.Helpers, as: Routes
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ToDoList.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ToDoList.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(ToDoList.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end

  def create_user() do
    password = Comeonin.Pbkdf2.hashpwsalt("12345678")
    insert(:user, password: password)
  end

  def sign_in(session) do
    sign_in(session, create_user())
  end

  def sign_in(session, user) do
    session
    |> visit("/sign-in")
    |> assert_has(text_field("credential"))
    |> fill_in(text_field("credential"), with: user.username)
    |> fill_in(text_field("password"), with: "12345678")
    |> click(button("Sign In!"))
    |> assert_has(link("Favorites"))
  end

  def wait_has(session, query), do: wait_has(session, query, 1)

  defp wait_has(session, query, attempt) when attempt > 5 do
    assert_has(session, query)
  end

  defp wait_has(session, query, attempt) do
    try do
      :timer.sleep(10)
      assert_has(session, query)
    rescue
      Wallaby.ExpectationNotMetError -> wait_has(session, query, 1 + attempt)
    end
  end
end
