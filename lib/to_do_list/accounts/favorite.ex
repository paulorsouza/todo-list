defmodule ToDoList.Accounts.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  alias ToDoList.Accounts.User
  alias ToDoList.ToDoLists.Task

  schema "favorites" do
    belongs_to(:task, Task)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:user_id, :task_id])
    |> validate_required([:user_id, :task_id])
  end
end
