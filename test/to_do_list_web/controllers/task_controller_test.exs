defmodule ToDoListWeb.TaskControllerTest do
  use ToDoListWeb.ConnCase
  import ToDoList.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "list public task" do
    @tag :authorized
    test "renders all public tasks", %{conn: conn} do
      insert(:task, public: false)
      insert(:task, public: true)
      insert(:task, public: true)
      insert(:task, public: true)

      conn = get(conn, Routes.public_task_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 3
    end

    @tag :authorized
    test "renders all public tasks with is_favorite", %{conn: conn, user: user} do
      favorite_task = insert(:task, public: true)
      favorite_task2 = insert(:task, public: true)
      task3 = insert(:task, public: true)
      insert(:favorite, task: favorite_task, user: user)
      insert(:favorite, task: favorite_task2, user: user)
      insert(:favorite, task: task3)
      conn = get(conn, Routes.recent_task_path(conn, :index))
      response = json_response(conn, 200)["data"]
      assert length(response) == 3
      assert Enum.count(response, fn task -> task["is_favorite"] end) == 2
    end
  end

  describe "create task" do
    @tag :authorized
    test "renders task when data is valid", %{conn: conn} do
      task = params_for(:task)
      conn = post(conn, Routes.task_path(conn, :create), task: task)
      assert %{"id" => id} = json_response(conn, 201)["data"]
      conn = get(conn, Routes.task_path(conn, :show, id))

      assert %{
               "id" => id,
               "public" => false,
               "title" => task_title
             } = json_response(conn, 200)["data"]
    end

    @tag :authorized
    test "renders errors when data is invalid", %{conn: conn} do
      task = params_for(:task, title: nil, public: nil)
      conn = post(conn, Routes.task_path(conn, :create), task: task)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show task" do
    @tag :authorized
    test "renders task with assocs", %{conn: conn} do
      user = insert(:user)
      task = insert(:task, user: user, public: true)
      insert(:task_item, task: task)
      insert(:task_item, task: task)
      insert(:task_item, task: task)

      conn = get(conn, Routes.task_path(conn, :show, task.id))

      assert %{
               "id" => id,
               "owner_name" => username,
               "public" => true,
               "task_items" => task_items,
               "title" => task_title
             } = json_response(conn, 200)["data"]

      assert username == user.username
      assert length(task_items) == 3
    end

    @tag :authorized
    test "renders task with flag read_only false", %{conn: conn, user: user} do
      task = insert(:task, user: user)
      conn = get(conn, Routes.task_path(conn, :show, task.id))
      assert false == json_response(conn, 200)["read_only"]
    end

    @tag :authorized
    test "renders task with flag read_only true", %{conn: conn} do
      user = insert(:user)
      task = insert(:task, user: user, public: true)
      conn = get(conn, Routes.task_path(conn, :show, task.id))
      assert true == json_response(conn, 200)["read_only"]
    end

    @tag :authorized
    test "renders task with flag is_favorite true", %{conn: conn, user: user} do
      task = insert(:task, user: user)
      insert(:favorite, task: task, user: user)
      conn = get(conn, Routes.task_path(conn, :show, task.id))
      assert true == json_response(conn, 200)["is_favorite"]
    end

    @tag :authorized
    test "returns 404 when task is not public and user is not task's owner", %{conn: conn} do
      another_user = insert(:user)
      task = insert(:task, user: another_user, public: false)
      conn = get(conn, Routes.task_path(conn, :show, task.id))
      assert json_response(conn, 404)["errors"] != %{}
    end
  end
end
