defmodule Blog.BlogContext.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.BlogContext.Post

  schema "comments" do
    field :message, :string
    belongs_to :posts, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
