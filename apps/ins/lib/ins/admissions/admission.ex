defmodule Ins.Admissions.Admission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ins.Admissions.Admission


  schema "admissions" do
    field :first_name, :string
    field :last_name, :string
    field :views, :integer
    belongs_to :enroller, Enroller

    timestamps()
  end

  @doc false
  def changeset(%Admission{} = admission, attrs) do
    admission
    |> cast(attrs, [:first_name, :last_name, :views])
    |> validate_required([:first_name, :last_name, :views])
  end
end
