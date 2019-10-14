defmodule ToDoList.ToDoLists.TaskItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias ToDoList.ToDoLists.Task

  schema "task_items" do
    field :done, :boolean, default: false
    field :title, :string

    belongs_to :task, Task

    timestamps()
  end

  @doc false
  def changeset(task_item, attrs) do
    task_item
    |> cast(attrs, [:title, :done, :task_id])
    |> validate_required([:title, :done])
  end
end
