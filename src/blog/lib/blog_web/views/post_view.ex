defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView

  def render("index.json", %{posts: posts}) do
    render_many(posts, PostView, "post.json")
  end

  def render("show.json", %{post: post}) do
    render_one(post, PostView, "post.json")
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      message: post.message,
      author: render_one(post.user, BlogWeb.UserView, "user_without_email.json")}
  end
end
