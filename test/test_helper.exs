ExUnit.start()
ExUnit.configure(exclude: [:need_network, :acceptance])

configuration = ExUnit.configuration()
includes = Keyword.get(configuration, :include)

acceptance? = Enum.any?(includes, fn i -> i == :acceptance end)

if(acceptance?) do
  {:ok, _} = Application.ensure_all_started(:wallaby)
  Application.put_env(:wallaby, :base_url, ToDoListWeb.Endpoint.url())
end

{:ok, _} = Application.ensure_all_started(:ex_machina)

Ecto.Adapters.SQL.Sandbox.mode(ToDoList.Repo, :manual)
