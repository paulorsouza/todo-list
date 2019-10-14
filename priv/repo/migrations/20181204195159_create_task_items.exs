defmodule ToDoList.Repo.Migrations.CreateTaskItems do
  use Ecto.Migration

  def change do
    create table(:task_items) do
      add :title, :string
      add :done, :boolean, default: false, null: false
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:task_items, [:task_id])
  end
end
