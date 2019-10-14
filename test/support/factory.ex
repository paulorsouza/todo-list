defmodule ToDoList.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: ToDoList.Repo

  alias ToDoList.Accounts.{User, Favorite}
  alias ToDoList.ToDoLists.{Task, TaskItem}

  def user_factory do
    %User{
      username: sequence(:username, &"user#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "12345678"
    }
  end

  def task_factory do
    %Task{
      title: sequence(:title, &"Title #{&1})"),
      public: false,
      user: build(:user)
    }
  end

  def task_item_factory do
    %TaskItem{
      title: sequence(:title, &"Item #{&1})"),
      done: false,
      task: build(:task)
    }
  end

  def favorite_factory do
    %Favorite{
      user: build(:user),
      task: build(:task)
    }
  end
end
