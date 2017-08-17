defmodule Ins.Admissions.Enroller do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ins.Admissions.{Enroller, Admission}


  schema "enrollers" do
    field :gender, :string
    field :role, :string
    has_one :admissions, Admission
    belongs_to :user, Ins.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Enroller{} = enroller, attrs) do
    enroller
    |> cast(attrs, [:role, :gender])
    |> validate_required([:role, :gender])
    |> unique_constraint(:user_id)
  end
end
