defmodule ToDoListWeb.Email do
  @moduledoc false

  use Bamboo.Phoenix, view: ToDoListWeb.EmailView

  def send_link_with_valid_token(user, token) do
    html = html(user.username, token)

    new_email()
    |> to(user.email)
    |> from("ptectodochallenge@gmail.com")
    |> subject("Access your account!")
    |> html_body(html)
  end

  defp html(username, token) do
    link = link_to_sign_in_with_token(token)

    """
    <p>Hello #{username},</p>

    <p>Click in #{link} to access your account and change your password.</p>
    """
  end

  defp link_to_sign_in_with_token(token) do
    sign_path =
      ToDoListWeb.Endpoint.url() <> ToDoListWeb.Endpoint.path("/recover-account/") <> token

    """
    <a href="#{sign_path}">link</a>
    """
  end
end
