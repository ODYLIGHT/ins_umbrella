defmodule InsWeb.AdmissionController do
  use InsWeb, :controller

  alias Ins.Admissions
  alias Ins.Admissions.Admission

  plug :require_existing_enroller
  plug :authorize_admission when action in [:edit, :update, :delete]

  def new(conn, _params) do
    changeset = Admissions.change_admission(%Admission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"admission" => admission_params}) do
    case Admissions.create_admission(conn.assigns.current_enroller, admission_params) do
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

  def edit(conn, %{"id" => id}) do
    admission = Admissions.get_admission!(id)
    changeset = Admissions.change_admission(admission)
    render(conn, "edit.html", admission: admission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "admission" => admission_params}) do
    admission = Admissions.get_admission!(id)

    case Admissions.update_admission(admission, admission_params) do
      {:ok, admission} ->
        conn
        |> put_flash(:info, "Admission updated successfully.")
        |> redirect(to: admission_path(conn, :show, admission))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", admission: admission, changeset: changeset)
    end
  end

  defp require_existing_enroller(conn, _) do
    enroller = Admissions.ensure_enroller_exists(conn.assigns.current_user)
    assign(conn, :current_enroller, enroller)
  end

  defp authorize_admission(conn, _) do
    admission = Admissions.get_admission!(conn.params["id"])

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
