defmodule BlogWeb.CommentView do
  use BlogWeb, :view
  alias BlogWeb.CommentView
  alias BlogWeb.UserView

  def render("index.json", %{comments: comments, post_id: post_id}) do
    %{
      postId: post_id,
      comments: render_many(comments, CommentView, "comment.json")
    }
  end

  def render("show.json", %{comment: comment}) do
    render_one(comment, CommentView, "comment.json")
  end

  def render("comment.json", %{comment: comment}) do
    comment = Blog.Repo.preload(comment, :user)

    %{id: comment.id,
      message: comment.message,
      author: render_one(comment.user, UserView, "user.json")}
  end
end
