defmodule ToDoListWeb.UserControllerTest do
  use ToDoListWeb.ConnCase
  import ToDoList.Factory

  alias ToDoList.Accounts

  @create_attrs %{
    email: "email@email.com",
    virtual_password: "some password",
    virtual_password_confirmation: "some password",
    username: "some username"
  }
  @invalid_attrs %{email: nil, password: nil, username: nil}

  describe "create user" do
    test "renders token when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert json_response(conn, 201)["token"] != nil
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "recover account" do
    @tag :need_network
    test "return success if user exists", %{conn: conn} do
      new_user = insert(:user, email: "paulor1809@gmail.com")

      conn =
        post(conn, Routes.user_path(conn, :recover_account), %{credential: new_user.username})

      assert response(conn, 200)
    end

    @tag :need_network
    test "return error if user not exists", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :recover_account), %{credential: "invalid"})
      assert json_response(conn, 422)["error"] == "User not found"
    end
  end

  describe "update user" do
    @tag :authorized
    test "renders token when data is valid", %{conn: conn, user: user} do
      attrs = %{
        email: "new@email.com",
        virtual_password: "teste123",
        virtual_password_confirmation: "teste123"
      }

      conn = put(conn, Routes.user_path(conn, :update), user: attrs)
      assert json_response(conn, 200)["token"] != nil
      updated_user = Accounts.get_user!(user.id)
      assert updated_user.email == attrs.email
    end

    @tag :authorized
    test "renders errors when data is invalid", %{conn: conn} do
      conn = put(conn, Routes.user_path(conn, :update), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show current user" do
    @tag :authorized
    test "renders user data", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :show))
      response = json_response(conn, 200)["data"]
      assert response["username"] == user.username
      assert response["email"] == user.email
    end

    test "renders error when user is unauthorized", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :show))
      assert json_response(conn, 401)["error"] == "unauthenticated"
    end
  end

  describe "my tasks" do
    @tag :authorized
    test "renders my tasks", %{conn: conn, user: user} do
      insert(:task)
      insert(:task, user: user)
      insert(:task, user: user)
      conn = get(conn, Routes.my_task_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 2
    end

    @tag :authorized
    test "renders empty tasks", %{conn: conn} do
      conn = get(conn, Routes.my_task_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 0
    end
  end

  describe "get user profile" do
    @tag :authorized
    test "renders private tasks when profile belongs to current user", %{conn: conn, user: user} do
      insert(:task, user: user, public: false)
      insert(:task, user: user, public: false)
      insert(:task, user: user, public: false)
      insert(:task, user: user, public: true)
      conn = get(conn, Routes.user_profile_path(conn, :show, user.username))
      assert length(json_response(conn, 200)["data"]) == 4
    end

    @tag :authorized
    test "renders only public tasks when profile does not belong to current user", %{conn: conn} do
      another_user = insert(:user)
      insert(:task, user: another_user, public: false)
      insert(:task, user: another_user, public: true)
      insert(:task, user: another_user, public: true)
      insert(:task, user: another_user, public: true)
      conn = get(conn, Routes.user_profile_path(conn, :show, another_user.username))
      assert length(json_response(conn, 200)["data"]) == 3
    end

    @tag :authorized
    test "renders with is_favorite tag", %{conn: conn, user: current_user} do
      another_user = insert(:user)
      task = insert(:task, user: another_user, public: true)
      task2 = insert(:task, user: another_user, public: true)
      task3 = insert(:task, user: another_user, public: true)
      insert(:favorite, task: task, user: current_user)
      insert(:favorite, task: task2, user: current_user)
      insert(:favorite, task: task3, user: current_user)

      conn = get(conn, Routes.user_profile_path(conn, :show, another_user.username))

      Enum.each(json_response(conn, 200)["data"], fn t ->
        assert t["is_favorite"]
      end)
    end

    @tag :authorized
    test "renders empty tasks", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_profile_path(conn, :show, user.username))
      assert length(json_response(conn, 200)["data"]) == 0
    end
  end
end
