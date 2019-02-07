defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{ posts: render_many(posts, PostView, "post.json") }
  end

  def render("show.json", %{post: post}) do
    render_one(post, PostView, "post.json")
  end

  def render("post.json", %{post: post}) do
    post = Blog.Repo.preload(post, :comments)

    %{id: post.id,
      message: post.message,
      author: render_one(post.user, BlogWeb.UserView, "user.json"),
      comments: render_many(post.comments, BlogWeb.CommentView, "comment.json")}
  end
end
