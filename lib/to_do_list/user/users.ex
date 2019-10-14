defmodule ToDoList.User.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
