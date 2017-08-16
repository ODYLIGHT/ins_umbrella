defmodule InsWeb.AdmissionController do
  use InsWeb, :controller

  alias Ins.Admissions
  alias Ins.Admissions.Admission

  # def index(conn, _params) do
  #   admissions = Admissions.list_admissions()
  #   render(conn, "index.html", admissions: admissions)
  # end

  def new(conn, _params) do
    changeset = Admissions.change_admission(%Admission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"admission" => admission_params}) do
    case Admissions.create_admission(admission_params) do
      {:ok, admission} ->
        conn
        |> put_flash(:info, "Admission created successfully.")
        |> redirect(to: admission_path(conn, :show, admission))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    admission = Admissions.get_admission!(id)
    render(conn, "show.html", admission: admission)
  end

  # def edit(conn, %{"id" => id}) do
  #   admission = Admissions.get_admission!(id)
  #   changeset = Admissions.change_admission(admission)
  #   render(conn, "edit.html", admission: admission, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "admission" => admission_params}) do
  #   admission = Admissions.get_admission!(id)

  #   case Admissions.update_admission(admission, admission_params) do
  #     {:ok, admission} ->
  #       conn
  #       |> put_flash(:info, "Admission updated successfully.")
  #       |> redirect(to: admission_path(conn, :show, admission))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", admission: admission, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   admission = Admissions.get_admission!(id)
  #   {:ok, _admission} = Admissions.delete_admission(admission)

  #   conn
  #   |> put_flash(:info, "Admission deleted successfully.")
  #   |> redirect(to: admission_path(conn, :index))
  # end
end
