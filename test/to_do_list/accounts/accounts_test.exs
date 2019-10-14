defmodule ToDoList.AccountsTest do
  use ToDoList.DataCase
  import ToDoList.Factory

  alias ToDoList.Accounts

  describe "users" do
    alias ToDoList.Accounts.User

    @valid_attrs %{
      email: "email@email",
      virtual_password: "12345678",
      virtual_password_confirmation: "12345678",
      username: "some username"
    }
    @update_attrs %{email: "email2@email", username: "some updated username"}
    @invalid_attrs %{email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    defp clean_virtual_password(user) do
      %{user | virtual_password: nil, virtual_password_confirmation: nil}
    end

    test "get_user_favorites!/1" do
      new_user = insert(:user)
      task1 = insert(:task)
      task2 = insert(:task)
      task3 = insert(:task)
      insert(:favorite, task: task1, user: new_user)
      insert(:favorite, task: task2, user: new_user)
      insert(:favorite, task: task3, user: new_user)
      favorites = Accounts.get_user_favorites!(new_user.id)
      assert length(favorites) == 3
    end

    test "get_user_tasks!/1" do
      user = insert(:user)
      insert(:task)
      insert(:task, user: user)
      insert(:task, user: user)
      tasks = Accounts.get_user_tasks!(user.id)
      assert length(tasks) == 2
      first = Enum.at(tasks, 0)
      assert first.user.username == user.username
    end

    test "get_user_profile!/1" do
      user = insert(:user)
      insert(:task)
      insert(:task, user: user)
      insert(:task, user: user)
      tasks = Accounts.get_user_profile!(user.username)
      assert length(tasks) == 2
      first = Enum.at(tasks, 0)
      assert first.user.username == user.username
    end

    test "get_user/1 returns user by email" do
      user_fixture()
      user = Accounts.get_user(@valid_attrs.email)
      assert user.username == @valid_attrs.username
    end

    test "get_user/1 returns user by username" do
      user_fixture()
      user = Accounts.get_user(@valid_attrs.username)
      assert user.email == @valid_attrs.email
    end

    test "get_user/1 returns nil when user not exist" do
      user_fixture()
      assert Accounts.get_user("teste") == nil
    end

    test "verify_password/2 returns user if password is correct" do
      user = user_fixture()
      assert user == user |> Accounts.verify_password("12345678")
    end

    test "verify_password/2 returns nil if password is not correct" do
      user = user_fixture()
      assert nil == user |> Accounts.verify_password("12345")
    end

    test "auth_user/3 returns guardian data if credentials is correct" do
      user = user_fixture()
      {:ok, _, claims} = Accounts.auth_user("email@email", "12345678")
      assert claims["sub"] == Integer.to_string(user.id)
    end

    test "auth_user/3 returns error if credentials is not correct" do
      user_fixture()
      assert {:error, "Unknown resource type"} == Accounts.auth_user("a", "12345")
    end

    test "encode_and_sign/1 returns user id in sub" do
      user = user_fixture()
      {:ok, _, claims} = Accounts.encode_and_sign(user)
      assert claims["sub"] == Integer.to_string(user.id)
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture() |> clean_virtual_password
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == @valid_attrs.email
      assert user.username == @valid_attrs.username
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == @update_attrs.email
      assert user.username == @update_attrs.username
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture() |> clean_virtual_password()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end
  end

  describe "favorites" do
    alias ToDoList.Accounts.Favorite

    test "create_favorite/1 with valid data creates a favorite" do
      favorite_params = params_with_assocs(:favorite)
      assert {:ok, %Favorite{} = favorite} = Accounts.create_favorite(favorite_params)
    end

    test "create_favorite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_favorite(%{user_id: "a", task_id: "b"})
    end

    test "delete_favorite/1 deletes the favorite" do
      favorite = insert(:favorite)
      {deleted_favorites, _} = Accounts.delete_favorite(favorite)
      assert deleted_favorites == 1
    end

    test "favorite?/2 return true" do
      favorite = insert(:favorite)
      assert Accounts.favorite?(favorite.task_id, favorite.user_id)
    end

    test "favorite?/2 return false" do
      refute Accounts.favorite?(-1, -1)
    end
  end

  describe "test" do
    alias ToDoList.Accounts.Test

    @valid_attrs %{integer: 120.5}
    @update_attrs %{integer: 456.7}
    @invalid_attrs %{integer: nil}

    def test_fixture(attrs \\ %{}) do
      {:ok, test} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_test()

      test
    end

    test "list_test/0 returns all test" do
      test = test_fixture()
      assert Accounts.list_test() == [test]
    end

    test "get_test!/1 returns the test with given id" do
      test = test_fixture()
      assert Accounts.get_test!(test.id) == test
    end

    test "create_test/1 with valid data creates a test" do
      assert {:ok, %Test{} = test} = Accounts.create_test(@valid_attrs)
      assert test.integer == 120.5
    end

    test "create_test/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_test(@invalid_attrs)
    end

    test "update_test/2 with valid data updates the test" do
      test = test_fixture()
      assert {:ok, %Test{} = test} = Accounts.update_test(test, @update_attrs)
      assert test.integer == 456.7
    end

    test "update_test/2 with invalid data returns error changeset" do
      test = test_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_test(test, @invalid_attrs)
      assert test == Accounts.get_test!(test.id)
    end

    test "delete_test/1 deletes the test" do
      test = test_fixture()
      assert {:ok, %Test{}} = Accounts.delete_test(test)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_test!(test.id) end
    end

    test "change_test/1 returns a test changeset" do
      test = test_fixture()
      assert %Ecto.Changeset{} = Accounts.change_test(test)
    end
  end
end
