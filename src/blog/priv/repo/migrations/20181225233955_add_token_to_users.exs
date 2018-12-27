defmodule Blog.Repo.Migrations.AddTokenToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :token, :uuid
    end

  end
end
