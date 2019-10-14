defmodule ToDoList.Accounts.Test do
  use Ecto.Schema
  import Ecto.Changeset

  schema "test" do
    field :integer, :float

    timestamps()
  end

  @doc false
  def changeset(test, attrs) do
    test
    |> cast(attrs, [:integer])
    |> validate_required([:integer])
  end
end
