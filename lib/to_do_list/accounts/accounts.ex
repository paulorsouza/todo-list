defmodule ToDoList.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  import Comeonin.Pbkdf2, only: [checkpw: 2]
  alias ToDoList.Repo

  alias ToDoList.Accounts.User

  @doc """
  Validates user authentication

  ## Examples

      iex> auth_user(username, email, correct_password)
      {:ok, jwt, claims}

      iex> auth_user(username, email, invalid_password)
      {:error, "Unknown resource type"}
  """
  def auth_user(credential, password) do
    credential
    |> get_user()
    |> verify_password(password)
    |> encode_and_sign()
  end

  @doc """
  Gets a single user by username or email.

  ## Examples

      iex> get_user(correct_username)
      %User{}

      iex> get_user(correct_email)
      {:ok, %User{}}

      iex> get_user(bad_value)
      nil
  """
  def get_user(credential) do
    query =
      from user in User,
        where: user.username == ^credential or user.email == ^credential

    Repo.one(query)
  end

  @doc """
  Check encrypt password

  ## Examples

      iex> verify_password(user, correct_password)
      %User{}

      iex> verify_password(user, invalid_password)
      nil
  """
  def verify_password(%User{} = user, password) do
    if checkpw(password, user.password) do
      user
    else
      nil
    end
  end

  def verify_password(nil, _) do
    nil
  end

  @doc """
  Generate jwt to user

  ## Examples

      iex> encode_and_sign(user)
      {:ok, jwt, claims}
  """
  def encode_and_sign(user) do
    ToDoList.Guardian.encode_and_sign(user)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets user favorite list.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_favorites!(123)
      [%Task{}, ...]

      iex> get_user_favorites!(323123)
      ** (Ecto.NoResultsError)

  """
  def get_user_favorites!(id) do
    get_user!(id)
    |> Repo.preload([:favorite_tasks])
    |> preload_favorite_tasks()
  end

  @doc """
  Gets user tasks.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_favorites(123)
      [%Task{}, ...]

      iex> get_user_favorites(323123)
      ** (Ecto.NoResultsError)

  """
  def get_user_tasks!(id) do
    get_user!(id)
    |> Repo.preload([:tasks])
    |> preload_user_tasks()
  end

  @doc """
  Gets a single user by username..

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_by_name!(username) do
    Repo.get_by!(User, username: username)
  end

  @doc """
  Gets a tasks of a user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_profile!(username)
      [%Task{}, ...]

      iex> get_user_profile!(invalid)
      ** (Ecto.NoResultsError)

  """
  def get_user_profile!(username) do
    get_user_by_name!(username)
    |> Repo.preload([:tasks])
    |> preload_user_tasks()
  end

  defp preload_favorite_tasks(user) do
    Enum.map(user.favorite_tasks, fn favorite ->
      favorite |> Repo.preload([:user, :task_items])
    end)
  end

  defp preload_user_tasks(user) do
    Enum.map(user.tasks, fn task ->
      task |> Repo.preload([:user, :task_items])
    end)
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  alias ToDoList.Accounts.Favorite

  @doc """
  Favorite a task.

  ## Examples

      iex> create_favorite(%{user_id: valid_user, task_id: valid_task})
      {:ok, %Favorite{}}

      iex> create_favorite(%{user_id: bad_user, task_id: bad_task})
      {:error, %Ecto.Changeset{}}

  """
  def create_favorite(attrs) do
    %Favorite{}
    |> Favorite.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Delete favorites.

  ## Examples

      iex> delete_favorite(favorite)
      {integer(), nil}

  """
  def delete_favorite(%{user_id: user_id, task_id: task_id}) do
    query = from(f in Favorite, where: f.user_id == ^user_id and f.task_id == ^task_id)
    Repo.delete_all(query)
  end

  @doc """
  Is favorite?

  ## Examples

      iex> favorite?(task, user)
      true

  """
  def favorite?(task_id, user_id) do
    query = from(f in Favorite, where: f.user_id == ^user_id and f.task_id == ^task_id)
    Repo.exists?(query)
  end

  alias ToDoList.Accounts.Test

  @doc """
  Returns the list of test.

  ## Examples

      iex> list_test()
      [%Test{}, ...]

  """
  def list_test do
    Repo.all(Test)
  end

  @doc """
  Gets a single test.

  Raises `Ecto.NoResultsError` if the Test does not exist.

  ## Examples

      iex> get_test!(123)
      %Test{}

      iex> get_test!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test!(id), do: Repo.get!(Test, id)

  @doc """
  Creates a test.

  ## Examples

      iex> create_test(%{field: value})
      {:ok, %Test{}}

      iex> create_test(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test(attrs \\ %{}) do
    %Test{}
    |> Test.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test.

  ## Examples

      iex> update_test(test, %{field: new_value})
      {:ok, %Test{}}

      iex> update_test(test, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test(%Test{} = test, attrs) do
    test
    |> Test.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Test.

  ## Examples

      iex> delete_test(test)
      {:ok, %Test{}}

      iex> delete_test(test)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test(%Test{} = test) do
    Repo.delete(test)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test changes.

  ## Examples

      iex> change_test(test)
      %Ecto.Changeset{source: %Test{}}

  """
  def change_test(%Test{} = test) do
    Test.changeset(test, %{})
  end
end
