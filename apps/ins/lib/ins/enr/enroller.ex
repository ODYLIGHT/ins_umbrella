defmodule Ins.ENR.Enroller do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ins.ENR.{Enroller, Admission}


  schema "enrollers" do
    field :gender, :string
    field :role, :string
    has_many :admissions, Admission
    belongs_to : :user, Ins.Accounts.User

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
