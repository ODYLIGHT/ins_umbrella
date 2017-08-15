defmodule Ins.Repo.Migrations.AddEnrollerIdToAdmissions do
  use Ecto.Migration

  def change do
    alter table(:admissions) do
      add :enroller_id, references(:enrollers, on_delete: :delete_all),
                      null: false
    end
  end
end
