defmodule Blog.BlogContext.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :message, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
