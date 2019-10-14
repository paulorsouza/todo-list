defmodule ToDoList.Repo.Migrations.CreateTest do
  use Ecto.Migration

  def change do
    create table(:test) do
      add :integer, :float

      timestamps()
    end

  end
end
