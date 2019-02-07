defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.BlogContext
  alias Blog.BlogContext.Post
  alias Blog.Repo

  action_fallback BlogWeb.FallbackController

  def index(conn, _params) do
    posts = BlogContext.list_posts()
    posts = Repo.preload(posts, :user)
    posts = Repo.preload(posts, :comments)
    render(conn, "index.json", posts: posts)
  end

  def create(conn, post_params) do
    token = conn |> get_req_header("token") |> List.first()

    with {:ok, %Post{} = post} <- BlogContext.create_post(token, post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    {id, _remainder_of_binary} = Integer.parse(id)
    post = BlogContext.get_post!(id)
    post = Blog.Repo.preload(post, :user)
    render(conn, "show.json", post: post)
  end

  def update(conn, post_params) do
    post = BlogContext.get_post!(post_params["id"])
    token = conn |> get_req_header("token") |> List.first()
    message = post_params["message"]

    token_valid =
      case Ecto.UUID.cast(token) do
        {:ok, _} -> true
        _ -> false
      end

    cond do
      (
        is_nil(token)
        || String.length(String.trim(token)) <= 0
        || !token_valid
      ) ->
        conn
        |> Plug.Conn.resp(:unauthorized, "") # 401
        |> Plug.Conn.send_resp
      (
        is_nil(message)
        || String.length(String.trim(message)) <= 0
      ) ->
        conn
        |> Plug.Conn.resp(:unprocessable_entity, "") # 422
        |> Plug.Conn.send_resp
      true ->
        with {:ok, %Post{} = post} <- BlogContext.update_post(post, token, post_params) do
          render(conn, "show.json", post: post)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    post = BlogContext.get_post!(id)
    token = conn |> get_req_header("token") |> List.first()

    token_valid =
      case Ecto.UUID.cast(token) do
        {:ok, _} -> true
        _ -> false
      end

    cond do
      (
      is_nil(token)
      || String.length(String.trim(token)) <= 0
      || !token_valid
      ) ->
        conn
        |> Plug.Conn.resp(:unauthorized, "") # 401
        |> Plug.Conn.send_resp
      true ->
        with {:ok, %Post{}} <- BlogContext.delete_post(post) do
          send_resp(conn, :no_content, "")
        end
    end
  end
end
