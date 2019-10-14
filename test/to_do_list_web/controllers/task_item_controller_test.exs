defmodule ToDoListWeb.TaskItemControllerTest do
  use ToDoListWeb.ConnCase
  import ToDoList.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create task_item" do
    @tag :authorized
    test "renders task_item when data is valid", %{conn: conn} do
      user = insert(:user)
      task = insert(:task, user: user)
      task_item = params_with_assocs(:task_item, task: task)
      create_url = Routes.task_task_item_path(conn, :create, task.id)
      conn = post(conn, create_url, task_item: task_item)
      assert %{"id" => id} = json_response(conn, 201)["data"]
      show_url = Routes.task_task_item_path(conn, :show, task.id, id)
      conn = get(conn, show_url)
      result = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "done" => false,
               "title" => title
             } = result
    end

    @tag :authorized
    test "renders errors when data is invalid", %{conn: conn} do
      task_item = params_for(:task_item, done: nil, title: nil)
      conn = post(conn, Routes.task_task_item_path(conn, :create, 1), task_item: task_item)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
