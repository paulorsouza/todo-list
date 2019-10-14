defmodule ToDoListWeb.FavoriteControllerTest do
  use ToDoListWeb.ConnCase
  import ToDoList.Factory

  describe "create favorite" do
    @tag :authorized
    test "returns 201 when data is valid", %{conn: conn} do
      favorite_params = params_with_assocs(:favorite)
      conn = post(conn, Routes.favorite_path(conn, :create), task_id: favorite_params.task_id)
      assert response(conn, 201)
    end

    @tag :authorized
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.favorite_path(conn, :create), task_id: nil)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete favorite" do
    @tag :authorized
    test "returns 204", %{conn: conn, user: user} do
      favorite = insert(:favorite, user: user)
      conn = delete(conn, Routes.favorite_path(conn, :delete), task_id: favorite.task_id)
      assert response(conn, 204)
    end
  end

  describe "my favorites" do
    @tag :authorized
    test "renders my favorite tasks", %{conn: conn, user: user} do
      task1 = insert(:task)
      task2 = insert(:task)
      task3 = insert(:task)
      insert(:favorite, task: task1, user: user)
      insert(:favorite, task: task2, user: user)
      insert(:favorite, task: task3, user: user)
      conn = get(conn, Routes.favorite_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 3
    end

    @tag :authorized
    test "renders empty favorite", %{conn: conn} do
      conn = get(conn, Routes.favorite_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 0
    end
  end
end
