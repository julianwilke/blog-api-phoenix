defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias Blog.BlogContext
  alias Blog.BlogContext.Comment

  action_fallback BlogWeb.FallbackController

  def index(conn, params) do
    comments = BlogContext.list_comments()
    render(conn, "index.json", comments: comments, post_id: params["post_id"])
  end

  def create(conn, comment_params) do
    token = conn |> get_req_header("token") |> List.first()
    post = BlogContext.get_post!(comment_params["post_id"])

    with {:ok, %Comment{} = comment} <- BlogContext.create_comment(token, post, comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_comment_path(conn, :show, post.id, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = BlogContext.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, comment_params) do
    comment = BlogContext.get_comment!(comment_params["id"])

    with {:ok, %Comment{} = comment} <- BlogContext.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = BlogContext.get_comment!(id)
    with {:ok, %Comment{}} <- BlogContext.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
