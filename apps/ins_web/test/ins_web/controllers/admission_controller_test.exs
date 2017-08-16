defmodule InsWeb.AdmissionControllerTest do
  use InsWeb.ConnCase

  alias Ins.Admissions

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", views: 42}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", views: 43}
  @invalid_attrs %{first_name: nil, last_name: nil, views: nil}

  def fixture(:admission) do
    {:ok, admission} = Admissions.create_admission(@create_attrs)
    admission
  end

  describe "index" do
    test "lists all admissions", %{conn: conn} do
      conn = get conn, admission_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Admissions"
    end
  end

  describe "new admission" do
    test "renders form", %{conn: conn} do
      conn = get conn, admission_path(conn, :new)
      assert html_response(conn, 200) =~ "New Admission"
    end
  end

  describe "create admission" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, admission_path(conn, :create), admission: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == admission_path(conn, :show, id)

      conn = get conn, admission_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Admission"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, admission_path(conn, :create), admission: @invalid_attrs
      assert html_response(conn, 200) =~ "New Admission"
    end
  end

  describe "edit admission" do
    setup [:create_admission]

    test "renders form for editing chosen admission", %{conn: conn, admission: admission} do
      conn = get conn, admission_path(conn, :edit, admission)
      assert html_response(conn, 200) =~ "Edit Admission"
    end
  end

  describe "update admission" do
    setup [:create_admission]

    test "redirects when data is valid", %{conn: conn, admission: admission} do
      conn = put conn, admission_path(conn, :update, admission), admission: @update_attrs
      assert redirected_to(conn) == admission_path(conn, :show, admission)

      conn = get conn, admission_path(conn, :show, admission)
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, admission: admission} do
      conn = put conn, admission_path(conn, :update, admission), admission: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Admission"
    end
  end

  describe "delete admission" do
    setup [:create_admission]

    test "deletes chosen admission", %{conn: conn, admission: admission} do
      conn = delete conn, admission_path(conn, :delete, admission)
      assert redirected_to(conn) == admission_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, admission_path(conn, :show, admission)
      end
    end
  end

  defp create_admission(_) do
    admission = fixture(:admission)
    {:ok, admission: admission}
  end
end
