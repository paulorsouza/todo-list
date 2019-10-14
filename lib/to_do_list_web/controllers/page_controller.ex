defmodule ToDoListWeb.PageController do
  use ToDoListWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
