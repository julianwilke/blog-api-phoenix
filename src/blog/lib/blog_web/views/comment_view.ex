defmodule BlogWeb.CommentView do
  use BlogWeb, :view
  alias BlogWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{comments: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    render_one(comment, CommentView, "comment.json")
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      message: comment.message}
  end
end
