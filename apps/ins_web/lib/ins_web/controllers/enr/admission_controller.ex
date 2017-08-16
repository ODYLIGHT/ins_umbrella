defmodule InsWeb.ENR.AdmissionController do
  use InsWeb, :controller

  alias Ins.ENR
  alias Ins.ENR.Admission

  plug :require_existing_enroller
  plug :authorize_admission when action in [:edit, :update, :delete]

  def index(conn, _params) do
    admissions = ENR.list_admissions()
    render(conn, "index.html", admissions: admissions)
  end

  def new(conn, _params) do
    changeset = ENR.change_admission(%Admission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"admission" => admission_params}) do
    case ENR.create_admission(conn.assigns.current_enroller, admission_params) do
      {:ok, admission} ->
        conn
        |> put_flash(:info, "Admission created successfully.")
        |> redirect(to: enr_admission_path(conn, :show, admission))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    admission = 
      id
      |> ENR.get_admission!()
      |> ENR.inc_admission_views()
    render(conn, "show.html", admission: admission)
  end

  def edit(conn, %{"id" => id}) do
    admission = ENR.get_admission!(id)
    changeset = ENR.change_admission(admission)
    render(conn, "edit.html", admission: admission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "admission" => admission_params}) do
    admission = ENR.get_admission!(id)

    case ENR.update_admission(conn.assigns.admission, admission_params) do
      {:ok, admission} ->
        conn
        |> put_flash(:info, "Admission updated successfully.")
        |> redirect(to: enr_admission_path(conn, :show, admission))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", admission: admission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    admission = ENR.get_admission!(id)
    {:ok, _admission} = ENR.delete_admission(conn.assigns.  admission)

    conn
    |> put_flash(:info, "Admission deleted successfully.")
    |> redirect(to: enr_admission_path(conn, :index))
  end

  defp require_existing_enroller(conn, _) do
    enroller = ENR.ensure_enroller_exists(conn.assigns.current_user)
    assign(conn, :current_enroller, enroller)
  end

  defp authorize_admission(conn, _) do
    admission = ENR.get_admission!(conn.params["id"])

    if conn.assigns.current_enroller.id == admission.enroller_id do
      assign(conn, :admission, admission)
    else
      conn
      |> put_flash(:error, "You can't modify that admission page")
      |> redirect(to: enr_admission_path(conn, :index))
      |> halt()
    end
  end
end
