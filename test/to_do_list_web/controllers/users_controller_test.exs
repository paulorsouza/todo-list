defmodule ToDoListWeb.UsersControllerTest do
  use ToDoListWeb.ConnCase

  alias ToDoList.User

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:users) do
    {:ok, users} = User.create_users(@create_attrs)
    users
  end

  describe "index" do
    test "lists all user", %{conn: conn} do
      conn = get(conn, Routes.users_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User"
    end
  end

  describe "new users" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.users_path(conn, :new))
      assert html_response(conn, 200) =~ "New Users"
    end
  end

  describe "create users" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.users_path(conn, :create), users: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.users_path(conn, :show, id)

      conn = get(conn, Routes.users_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Users"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.users_path(conn, :create), users: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Users"
    end
  end

  describe "edit users" do
    setup [:create_users]

    test "renders form for editing chosen users", %{conn: conn, users: users} do
      conn = get(conn, Routes.users_path(conn, :edit, users))
      assert html_response(conn, 200) =~ "Edit Users"
    end
  end

  describe "update users" do
    setup [:create_users]

    test "redirects when data is valid", %{conn: conn, users: users} do
      conn = put(conn, Routes.users_path(conn, :update, users), users: @update_attrs)
      assert redirected_to(conn) == Routes.users_path(conn, :show, users)

      conn = get(conn, Routes.users_path(conn, :show, users))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, users: users} do
      conn = put(conn, Routes.users_path(conn, :update, users), users: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Users"
    end
  end

  describe "delete users" do
    setup [:create_users]

    test "deletes chosen users", %{conn: conn, users: users} do
      conn = delete(conn, Routes.users_path(conn, :delete, users))
      assert redirected_to(conn) == Routes.users_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.users_path(conn, :show, users))
      end
    end
  end

  defp create_users(_) do
    users = fixture(:users)
    {:ok, users: users}
  end
end
