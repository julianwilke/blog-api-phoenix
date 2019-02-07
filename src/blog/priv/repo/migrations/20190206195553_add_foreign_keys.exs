defmodule Blog.Repo.Migrations.AddForeignKeys do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :user_id, references(:users, on_delete: :nilify_all)
    end
    alter table(:comments) do
      add :post_id, references(:posts, on_delete: :nilify_all)
    end
  end
end
