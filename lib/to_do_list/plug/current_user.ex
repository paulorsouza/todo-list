defmodule ToDoList.Plug.CurrentUser do
  @moduledoc """
  Plug to get current user from guardian
  """

  import Plug.Conn

  alias ToDoList.Guardian

  def init(options), do: options

  def call(conn, _options) do
    current_user = Guardian.Plug.current_resource(conn)
    conn = assign(conn, :current_user, current_user)
    conn
  end
end
