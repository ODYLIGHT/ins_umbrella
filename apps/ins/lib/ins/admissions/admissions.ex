defmodule Ins.Admissions do
  @moduledoc """
  The Admissions context.
  """

  import Ecto.Query, warn: false
  alias Ins.Repo

  alias Ins.Admissions.Admission

  @doc """
  Returns the list of admissions.

  ## Examples

      iex> list_admissions()
      [%Admission{}, ...]

  """
  def list_admissions do
    Repo.all(Admission)
  end

  @doc """
  Gets a single admission.

  Raises `Ecto.NoResultsError` if the Admission does not exist.

  ## Examples

      iex> get_admission!(123)
      %Admission{}

      iex> get_admission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admission!(id), do: Repo.get!(Admission, id)

  @doc """
  Creates a admission.

  ## Examples

      iex> create_admission(%{field: value})
      {:ok, %Admission{}}

      iex> create_admission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admission(attrs \\ %{}) do
    %Admission{}
    |> Admission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admission.

  ## Examples

      iex> update_admission(admission, %{field: new_value})
      {:ok, %Admission{}}

      iex> update_admission(admission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admission(%Admission{} = admission, attrs) do
    admission
    |> Admission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Admission.

  ## Examples

      iex> delete_admission(admission)
      {:ok, %Admission{}}

      iex> delete_admission(admission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admission(%Admission{} = admission) do
    Repo.delete(admission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admission changes.

  ## Examples

      iex> change_admission(admission)
      %Ecto.Changeset{source: %Admission{}}

  """
  def change_admission(%Admission{} = admission) do
    Admission.changeset(admission, %{})
  end
end
