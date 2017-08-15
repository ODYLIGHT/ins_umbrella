defmodule Ins.Repo.Migrations.CreateEnrollers do
  use Ecto.Migration

  def change do
    create table(:enrollers) do
      add :role, :string
      add :gender, :string
      add :user_id, references(:users, on_delete: :delete_all),
                    null: false

      timestamps()
    end

    create unique_index(:enrollers, [:user_id])
  end
end
