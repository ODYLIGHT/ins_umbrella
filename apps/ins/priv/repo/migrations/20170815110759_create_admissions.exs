defmodule Ins.Repo.Migrations.CreateAdmissions do
  use Ecto.Migration

  def change do
    create table(:admissions) do
      add :first_name, :string
      add :last_name, :string
      add :views, :integer

      timestamps()
    end

  end
end
