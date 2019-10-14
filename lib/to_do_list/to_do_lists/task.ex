defmodule ToDoList.ToDoLists.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias ToDoList.ToDoLists.TaskItem
  alias ToDoList.Accounts.User
  alias ToDoList.Accounts.Favorite

  schema "tasks" do
    field :public, :boolean, default: false
    field :title, :string
    field :is_favorite, :boolean, default: false, virtual: true

    belongs_to :user, User, foreign_key: :owner

    has_many :task_items, TaskItem
    has_many :favorites, Favorite

    many_to_many(:favorite_users, User, join_through: Favorite)

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :public, :owner])
    |> validate_required([:title, :public])
  end
end
