defmodule BlogWeb.UserController do
  use BlogWeb, :controller

  alias Blog.Blogs
  alias Blog.Blogs.User

  action_fallback BlogWeb.FallbackController

  def index(conn, _params) do
    users = Blogs.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Blogs.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Blogs.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Blogs.get_user!(id)

    with {:ok, %User{} = user} <- Blogs.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Blogs.get_user!(id)
    with {:ok, %User{}} <- Blogs.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end