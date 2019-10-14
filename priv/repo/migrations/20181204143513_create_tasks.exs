defmodule ToDoList.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :public, :boolean, default: false, null: false
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:owner])
  end
end
