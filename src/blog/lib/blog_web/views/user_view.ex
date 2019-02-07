defmodule BlogWeb.UserView do
  use BlogWeb, :view
  alias BlogWeb.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("show_user_with_token.json", %{user: user}) do
    render_one(user, UserView, "user_with_token.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email}
  end

  def render("user_without_email.json", %{user: user}) do
    %{id: user.id,
      name: user.name}
  end

  def render("user_with_token.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      token: user.token}
  end
end
