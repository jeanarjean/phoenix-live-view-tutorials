defmodule Tutorial.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :category, :string

      timestamps()
    end
  end
end
