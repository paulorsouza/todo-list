use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :to_do_list, ToDoListWeb.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :to_do_list, ToDoList.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "to_do_list_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :to_do_list, :sql_sandbox, true

config :wallaby,
  driver: Wallaby.Experimental.Selenium
