defmodule Ins.ENR do
  @moduledoc """
  The ENR context.
  """

  import Ecto.Query, warn: false
  alias Ins.Repo

  alias Ins.ENR.Admission
  alias Ins.ENR.Enroller
  alias Ins.ENR.{Admission, Enroller}
  alias Ins.Accounts
  
  @doc """
  Returns the list of admissions.
  
  ## Examples

      iex> list_admissions()
      [%Admission{}, ...]

  """
  def list_admissions do
    Admission
    |> Repo.all()
    |> Repo.preload(enroller: [user: :credential])
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
  def get_admission!(id) do
    Admission
    |> Repo.get!(id)
    |> Repo.preload(enroller: [user: :credential])
  end

  @doc """
  Creates a admission.

  ## Examples

      iex> create_admission(%{field: value})
      {:ok, %Admission{}}

      iex> create_admission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admission(%Enroller{} = enroller, attrs \\ %{}) do
    %Admission{}
    |> Admission.changeset(attrs)
    |> Ecto.Changeset.put_change(:enroller_id, enroller.id)
    |> Repo.insert()
  end

  def ensure_enroller_exists(%Accounts.User{} = user) do
    %Enroller{user_id: user.id}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.unique_constraint(:user_id)
    |> Repo.insert()
    |> handle_existing_enroller()
  end
  defp handle_existing_enroller({:ok, enroller}), do: enroller
  defp handle_existing_enroller({:error, changeset}) do
    Repo.get_by!(Enroller, user_id: changeset.data.user_id)
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

  

  @doc """
  Returns the list of enrollers.

  ## Examples

      iex> list_enrollers()
      [%Enroller{}, ...]

  """
  def list_enrollers do
    Repo.all(Enroller)
  end

  @doc """
  Gets a single enroller.

  Raises `Ecto.NoResultsError` if the Enroller does not exist.

  ## Examples

      iex> get_enroller!(123)
      %Enroller{}

      iex> get_enroller!(456)
      ** (Ecto.NoResultsError)

  """
  def get_enroller!(id) do
    Enroller
    |> Repo.get!(id)
    |> Repo.preload(user: :credential)
  end

  @doc """
  Creates a enroller.

  ## Examples

      iex> create_enroller(%{field: value})
      {:ok, %Enroller{}}

      iex> create_enroller(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_enroller(attrs \\ %{}) do
    %Enroller{}
    |> Enroller.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a enroller.

  ## Examples

      iex> update_enroller(enroller, %{field: new_value})
      {:ok, %Enroller{}}

      iex> update_enroller(enroller, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_enroller(%Enroller{} = enroller, attrs) do
    enroller
    |> Enroller.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Enroller.

  ## Examples

      iex> delete_enroller(enroller)
      {:ok, %Enroller{}}

      iex> delete_enroller(enroller)
      {:error, %Ecto.Changeset{}}

  """
  def delete_enroller(%Enroller{} = enroller) do
    Repo.delete(enroller)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking enroller changes.

  ## Examples

      iex> change_enroller(enroller)
      %Ecto.Changeset{source: %Enroller{}}

  """
  def change_enroller(%Enroller{} = enroller) do
    Enroller.changeset(enroller, %{})
  end

  def inc_admission_views(%Admission{} = admission) do
    {1, [%Admission{views: views}]} =
      Repo.update_all(
        from(a in Admission, where: a.id == ^admission.id),
        [inc: [views: 1]], returning: [:views])
  
    put_in(admission.views, views)
  end
end
