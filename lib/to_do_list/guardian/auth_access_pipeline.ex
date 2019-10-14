defmodule ToDoList.Guardian.AuthAccessPipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :my_app,
    module: ToDoList.Guardian,
    error_handler: ToDoList.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug ToDoList.Plug.CurrentUser
end
