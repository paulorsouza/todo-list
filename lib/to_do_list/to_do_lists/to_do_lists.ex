defmodule ToDoList.ToDoLists do
  @moduledoc """
  The ToDoLists context.
  """

  import Ecto.Query, warn: false
  alias ToDoList.Repo

  alias ToDoList.ToDoLists.Task
  alias ToDoList.Accounts.Favorite

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Returns the list of public lists.

  ## Examples

      iex> list_public_tasks()
      [%Task{}, ...]

  """
  def list_public_tasks do
    public_tasks_query() |> Repo.all()
  end

  @doc """
  Returns the list of public lists.

  ## Examples

      iex> list_public_tasks(user_id)
      [%Task{}, ...]

  """
  def list_public_tasks(user_id) do
    public_tasks_query()
    |> with_favorite_query(user_id)
    |> Repo.all()
  end

  @doc """
  Returns the tasks of a user.

  ## Examples

      iex> list_public_tasks(username)
      [%Task{}, ...]

  """
  def list_user_tasks(owner, favorited_by: current_user) do
    from(task in Task,
      where: task.owner == ^owner.id,
      order_by: [desc: task.id],
      preload: [:user, :task_items]
    )
    |> with_favorite_query(current_user.id)
    |> filter_profile(current_user.id)
    |> Repo.all()
  end

  defp public_tasks_query do
    from task in Task,
      where: task.public == true,
      order_by: [desc: task.id],
      preload: [:user, :task_items]
  end

  defp filter_profile(query, user_id) do
    from(task in query,
      where: task.owner == ^user_id or task.public == true
    )
  end

  defp with_favorite_query(query, user_id) do
    from task in query,
      left_join: favorite in Favorite,
      on: favorite.user_id == ^user_id and favorite.task_id == task.id,
      select: %{task | is_favorite: not is_nil(favorite.user_id)}
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
    |> Repo.preload([:user, :task_items])
  end

  @doc """
  Gets a single task.

  Returns nil if the task is not public
  and current user is not task's owner
  or when the task doesn't exist.

  ## Examples

      iex> get_task(task_id, owner_id)
      %Task{}

      iex> get_task(public_task_id, another_user_id)
      %Task{}

      iex> get_task(private_task_id, another_user_id)
      nil

  """
  def get_task(task_id, user_id) do
    sub_query =
      from item in ToDoList.ToDoLists.TaskItem,
        group_by: item.task_id,
        select: %{task_id: item.task_id, last_updated: max(item.updated_at)}

    query =
      from task in Task,
        left_join: item in subquery(sub_query),
        on: item.task_id == task.id,
        where:
          task.id == ^task_id and
            (task.owner == ^user_id or
               task.public == true),
        select: %{task | updated_at: item.last_updated},
        preload: [:user, :task_items]

    Repo.one(query)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias ToDoList.ToDoLists.TaskItem

  @doc """
  Returns the list of task_items.

  ## Examples

      iex> list_task_items()
      [%TaskItem{}, ...]

  """
  def list_task_items do
    Repo.all(TaskItem)
  end

  @doc """
  Gets a single task_item.

  Raises `Ecto.NoResultsError` if the Task item does not exist.

  ## Examples

      iex> get_task_item!(123)
      %TaskItem{}

      iex> get_task_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task_item!(id) do
    Repo.get!(TaskItem, id)
  end

  @doc """
  Creates a task_item.

  ## Examples

      iex> create_task_item(%{field: value})
      {:ok, %TaskItem{}}

      iex> create_task_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task_item(attrs \\ %{}) do
    %TaskItem{}
    |> TaskItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a task_item.

  ## Examples

      iex> create_task_item(%{field: value})
      {:ok, %TaskItem{}}

      iex> create_task_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def preload(task_item, preload_args) do
    Repo.preload(task_item, preload_args)
  end

  @doc """
  Updates a task_item.

  ## Examples

      iex> update_task_item(task_item, %{field: new_value})
      {:ok, %TaskItem{}}

      iex> update_task_item(task_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task_item(%TaskItem{} = task_item, attrs) do
    task_item
    |> TaskItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TaskItem.

  ## Examples

      iex> delete_task_item(task_item)
      {:ok, %TaskItem{}}

      iex> delete_task_item(task_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task_item(%TaskItem{} = task_item) do
    Repo.delete(task_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task_item changes.

  ## Examples

      iex> change_task_item(task_item)
      %Ecto.Changeset{source: %TaskItem{}}

  """
  def change_task_item(%TaskItem{} = task_item) do
    TaskItem.changeset(task_item, %{})
  end
end
