defmodule Blog.BlogContext.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.BlogContext.User
  alias Blog.BlogContext.Comment

  schema "posts" do
    field :message, :string
    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
