defmodule ToDoList.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ToDoList.ToDoLists.Task
  alias ToDoList.Accounts.Favorite

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string

    field :virtual_password, :string, virtual: true
    field :virtual_password_confirmation, :string, virtual: true

    has_many :tasks, Task, foreign_key: :owner
    has_many :favorites, Favorite

    many_to_many(:favorite_tasks, Task, join_through: Favorite)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :virtual_password, :virtual_password_confirmation])
    |> validate_required([:username, :email, :virtual_password, :virtual_password_confirmation])
    |> validate_format(:username, ~r/[a-zA-Z0-9]$/)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:virtual_password)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{virtual_password: pw}} ->
        put_change(changeset, :password, Comeonin.Pbkdf2.hashpwsalt(pw))

      _ ->
        changeset
    end
  end
end
