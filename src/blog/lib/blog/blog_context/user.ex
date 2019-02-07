defmodule Blog.BlogContext.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.BlogContext.Post
  alias Blog.BlogContext.Comment

  schema "users" do
    field :email, :string
    field :name, :string
    field :token, Ecto.UUID, [autogenerate: true]
    has_many :posts, Post
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
