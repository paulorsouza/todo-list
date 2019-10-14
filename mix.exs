defmodule ToDoList.Mixfile do
  use Mix.Project

  def project do
    [
      app: :to_do_list,
      version: "0.0.1",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ToDoList.Application, []},
      extra_applications: [:logger, :runtime_tools, :bamboo]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.7"},
      {:gettext, "~> 0.15.0"},
      {:phoenix, "~> 1.4.0"},
      {:ecto_sql, "~> 3.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.12.0"},
      {:phoenix_live_reload, "~> 1.1.5", only: :dev},
      {:phoenix_pubsub, "~> 1.1.0"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.0"},
      {:guardian, "~> 1.0"},
      {:comeonin, "~> 4.0"},
      {:pbkdf2_elixir, "~> 0.12"},
      {:ex_machina, "~> 2.2", only: :test},
      {:bamboo, "~> 1.1"},
      {:bamboo_smtp, "~> 1.6.0"},
      {:wallaby, "~> 0.20.0", [runtime: false, only: :test]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      "test.acceptance": [
        "assets.compile --quiet",
        "ecto.create --quiet",
        "ecto.migrate",
        "run.acceptance.test"
      ],
      "assets.compile": &compile_assets/1,
      "run.acceptance.test": &run_acceptance_test/1
    ]
  end

  defp compile_assets(_) do
    Mix.shell().cmd(
      "cd assets && node node_modules/webpack/bin/webpack.js --mode production && cd .."
    )
  end

  def run_acceptance_test(_) do
    Mix.shell().cmd("mix test --only acceptance")
  end
end
