defmodule ToDoList.UserTest do
  use ToDoList.DataCase

  alias ToDoList.User

  describe "user" do
    alias ToDoList.User.Users

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def users_fixture(attrs \\ %{}) do
      {:ok, users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_users()

      users
    end

    test "list_user/0 returns all user" do
      users = users_fixture()
      assert User.list_user() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert User.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      assert {:ok, %Users{} = users} = User.create_users(@valid_attrs)
      assert users.name == "some name"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      assert {:ok, %Users{} = users} = User.update_users(users, @update_attrs)
      assert users.name == "some updated name"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_users(users, @invalid_attrs)
      assert users == User.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = User.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> User.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = User.change_users(users)
    end
  end
end
