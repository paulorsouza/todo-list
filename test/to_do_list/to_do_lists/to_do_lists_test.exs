defmodule ToDoList.ToDoListsTest do
  use ToDoList.DataCase
  import ToDoList.Factory

  alias ToDoList.ToDoLists

  describe "tasks" do
    alias ToDoList.ToDoLists.Task

    @update_attrs %{public: true, title: "some updated title"}
    @invalid_attrs %{public: nil, title: nil}

    test "list_public_tasks/0 lists only public tasks" do
      insert(:task, public: false)
      insert(:task, public: true)
      insert(:task, public: true)
      insert(:task, public: true)

      list = ToDoLists.list_public_tasks()
      assert length(list) == 3
    end

    test "list_user_tasks/2 lists all tasks" do
      user = insert(:user)
      insert(:task, public: false, user: user)
      insert(:task, public: true, user: user)
      insert(:task, public: true, user: user)
      insert(:task, public: true, user: user)

      list = ToDoLists.list_user_tasks(user, favorited_by: user)
      assert length(list) == 4
    end

    test "list_user_tasks/2 lists all with favorite tag" do
      owner = insert(:user)
      current_user = insert(:user)
      task = insert(:task, public: true, user: owner)
      task2 = insert(:task, public: true, user: owner)
      task3 = insert(:task, public: true, user: owner)
      task4 = insert(:task, public: true, user: owner)
      insert(:favorite, task: task, user: current_user)
      insert(:favorite, task: task2, user: current_user)
      insert(:favorite, task: task3, user: current_user)
      insert(:favorite, task: task4, user: current_user)

      list = ToDoLists.list_user_tasks(owner, favorited_by: current_user)

      Enum.each(list, fn t ->
        assert t.is_favorite
      end)

      assert length(list) == 4
    end

    test "list_with_favorite/2 lists tasks with tag is_favorite" do
      user = insert(:user)
      favorite_task = insert(:task, public: true)
      favorite_task2 = insert(:task, public: true)
      insert(:task, public: true)
      insert(:favorite, task: favorite_task, user: user)
      insert(:favorite, task: favorite_task2, user: user)
      list = ToDoLists.list_public_tasks(user.id)
      assert length(list) == 3
      assert Enum.count(list, fn task -> task.is_favorite end) == 2
    end

    test "list_public_tasks/0 lists public tasks ordered by more recent task" do
      insert(:task, public: true)
      last = insert(:task, public: true)

      list = ToDoLists.list_public_tasks()
      assert last.id == Enum.at(list, 0).id
    end

    test "returns last task_item update_at" do
      task = insert(:task, public: true)
      insert(:task_item, task: task)
      insert(:task_item, task: task)
      last_item = insert(:task_item, task: task)
      another_user = insert(:user)

      new_task = ToDoLists.get_task(task.id, another_user.id)
      assert new_task.inserted_at == task.inserted_at
      assert new_task.updated_at == last_item.updated_at
    end

    test "list_tasks/0 returns all tasks" do
      valid_task = insert(:task)
      first_task = ToDoLists.list_tasks() |> Enum.at(0)
      assert first_task.id == valid_task.id
    end

    test "returns nil when id not exists" do
      assert nil == ToDoLists.get_task(1, 1)
    end

    test "returns nil when the task is not public and the user is not owner" do
      task = insert(:task, public: false)
      another_user = insert(:user)
      assert nil == ToDoLists.get_task(task.id, another_user.id)
    end

    test "returns task when current user is the task owner" do
      user = insert(:user)
      task = insert(:task, user: user, public: false)

      refute nil == ToDoLists.get_task(task.id, user.id)
    end

    test "returns the task with given id" do
      user = insert(:user)
      insert(:task, public: true, user: user)
      insert(:task, public: true)
      task = insert(:task, public: false, user: user)

      result = ToDoLists.get_task(task.id, user.id)

      assert result.id == task.id
    end

    test "get_task!/1 returns the task with given id" do
      valid_task = insert(:task)

      task = ToDoLists.get_task!(valid_task.id)
      assert task.id == valid_task.id
    end

    test "create_task/1 with valid data creates a task" do
      task_params = params_for(:task)
      assert {:ok, %Task{} = task} = ToDoLists.create_task(task_params)
      assert task.public == task_params.public
      assert task.title == task_params.title
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ToDoLists.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      valid_task = insert(:task)
      assert {:ok, %Task{} = task} = ToDoLists.update_task(valid_task, @update_attrs)
      assert task.public == true
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      valid_task = insert(:task)
      assert {:error, %Ecto.Changeset{}} = ToDoLists.update_task(valid_task, @invalid_attrs)
      task = ToDoLists.get_task!(valid_task.id)
      assert valid_task.public == task.public
      assert valid_task.title == task.title
    end

    test "delete_task/1 deletes the task" do
      valid_task = insert(:task)
      assert {:ok, %Task{}} = ToDoLists.delete_task(valid_task)
      assert_raise Ecto.NoResultsError, fn -> ToDoLists.get_task!(valid_task.id) end
    end

    test "change_task/1 returns a task changeset" do
      valid_task = insert(:task)
      assert %Ecto.Changeset{} = ToDoLists.change_task(valid_task)
    end
  end

  describe "task_items" do
    alias ToDoList.ToDoLists.TaskItem

    @valid_attrs %{done: true, title: "some title"}
    @update_attrs %{done: false, title: "some updated title"}
    @invalid_attrs %{done: nil, title: nil}

    def task_item_fixture(attrs \\ %{}) do
      {:ok, task_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ToDoLists.create_task_item()

      task_item
    end

    test "list_task_items/0 returns all task_items" do
      task_item = task_item_fixture()
      assert ToDoLists.list_task_items() == [task_item]
    end

    test "get_task_item!/1 returns the task_item with given id" do
      task_item = task_item_fixture()
      assert ToDoLists.get_task_item!(task_item.id) == task_item
    end

    test "create_task_item/1 with valid data creates a task_item" do
      assert {:ok, %TaskItem{} = task_item} = ToDoLists.create_task_item(@valid_attrs)
      assert task_item.done == true
      assert task_item.title == "some title"
    end

    test "create_task_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ToDoLists.create_task_item(@invalid_attrs)
    end

    test "update_task_item/2 with valid data updates the task_item" do
      task_item = task_item_fixture()
      assert {:ok, %TaskItem{} = task_item} = ToDoLists.update_task_item(task_item, @update_attrs)
      assert task_item.done == false
      assert task_item.title == "some updated title"
    end

    test "update_task_item/2 with invalid data returns error changeset" do
      task_item = task_item_fixture()
      assert {:error, %Ecto.Changeset{}} = ToDoLists.update_task_item(task_item, @invalid_attrs)
      assert task_item == ToDoLists.get_task_item!(task_item.id)
    end

    test "delete_task_item/1 deletes the task_item" do
      task_item = task_item_fixture()
      assert {:ok, %TaskItem{}} = ToDoLists.delete_task_item(task_item)
      assert_raise Ecto.NoResultsError, fn -> ToDoLists.get_task_item!(task_item.id) end
    end

    test "change_task_item/1 returns a task_item changeset" do
      task_item = task_item_fixture()
      assert %Ecto.Changeset{} = ToDoLists.change_task_item(task_item)
    end
  end
end
