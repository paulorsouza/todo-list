defmodule ToDoList.Guardian.AuthErrorHandler do
  @moduledoc """
  Encode errors found in Guardian pipeline,
  then change conn to response this request with encoded error.
  """

  import Plug.Conn

  def auth_error(conn, {type, _}, _opts) do
    body = Jason.encode!(%{error: to_string(type)})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
