defmodule BlogWeb.UserController do
  use BlogWeb, :controller

  alias Blog.BlogContext
  alias Blog.BlogContext.User

  action_fallback BlogWeb.FallbackController

  def index(conn, _params) do
    users = BlogContext.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- BlogContext.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = BlogContext.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, params) do
    user = BlogContext.get_user!(params["id"])

    user_params = Map.delete(params, :id)

    with {:ok, %User{} = user} <- BlogContext.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = BlogContext.get_user!(id)
    with {:ok, %User{}} <- BlogContext.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
