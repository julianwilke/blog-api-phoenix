defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  import Ecto.Query

  alias Blog.BlogContext
  alias Blog.BlogContext.Post
  alias Ecto.Changeset
  alias Blog.Repo

  action_fallback BlogWeb.FallbackController

  def index(conn, _params) do
    posts = BlogContext.list_posts()
    posts = Repo.preload(posts, :user)
    # add comments query
    render(conn, "index.json", posts: posts)
  end

  def create(conn, post_params) do
    with {:ok, %Post{} = post} <- BlogContext.create_post(post_params) do
      post = Repo.preload(post, :user)

      token = conn |> get_req_header("token") |> List.first()
      user_query = from u in Blog.BlogContext.User, where: u.token == ^token, select: u
      user = Blog.Repo.one!(user_query)
      changeset = post |> Changeset.change() |> Changeset.put_assoc(:user, user)

      post = Repo.update!(changeset)

      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = BlogContext.get_post!(id)
    post = Blog.Repo.preload(post, :user)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = BlogContext.get_post!(id)

    with {:ok, %Post{} = post} <- BlogContext.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = BlogContext.get_post!(id)
    with {:ok, %Post{}} <- BlogContext.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
