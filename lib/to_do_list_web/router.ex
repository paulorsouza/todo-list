defmodule ToDoListWeb.Router do
  use ToDoListWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug ToDoList.Guardian.AuthAccessPipeline
  end

  scope "/api/v1", ToDoListWeb do
    pipe_through :api

    resources "/sign_up", UserController, only: [:create]
    resources "/sign_in", SessionController, only: [:create]
    resources "/recover_account", RecoverAccountController, only: [:create]
    resources "/public_tasks", PublicTaskController, only: [:index]
  end

  scope "/api/v1", ToDoListWeb do
    pipe_through [:api, :authenticated]

    resources "/user/current", UserController, only: [:show, :update], singleton: true
    resources "/user/:username/profile", UserProfileController, only: [:show], singleton: true
    resources "/my_tasks", User.TaskController, only: [:index], as: :my_task
    resources "/recent_tasks", RecentTaskController, only: [:index]

    resources "/task", TaskController, except: [:new, :edit] do
      resources "/task_items", TaskItemController, except: [:new, :edit]
    end

    resources "/favorites", FavoriteController, only: [:create, :delete], singleton: true
    resources "/favorites", FavoriteController, only: [:index]
  end

  scope "/", ToDoListWeb do
    # Use the default browser stack
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
