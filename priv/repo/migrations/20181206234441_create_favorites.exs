defmodule ToDoList.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :user_id, references(:users, on_delete: :nothing)
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:favorites, [:user_id])
    create index(:favorites, [:task_id])
  end
end
