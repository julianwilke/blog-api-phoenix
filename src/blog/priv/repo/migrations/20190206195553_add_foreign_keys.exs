defmodule Blog.Repo.Migrations.AddForeignKeys do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :user_id, :id
    end
    alter table(:comments) do
      add :post_id, :id
    end
  end
end
