defmodule Ins.ENRTest do
  use Ins.DataCase

  alias Ins.ENR

  describe "admissions" do
    alias Ins.ENR.Admission

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", views: 42}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", views: 43}
    @invalid_attrs %{first_name: nil, last_name: nil, views: nil}

    def admission_fixture(attrs \\ %{}) do
      {:ok, admission} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ENR.create_admission()

      admission
    end

    test "list_admissions/0 returns all admissions" do
      admission = admission_fixture()
      assert ENR.list_admissions() == [admission]
    end

    test "get_admission!/1 returns the admission with given id" do
      admission = admission_fixture()
      assert ENR.get_admission!(admission.id) == admission
    end

    test "create_admission/1 with valid data creates a admission" do
      assert {:ok, %Admission{} = admission} = ENR.create_admission(@valid_attrs)
      assert admission.first_name == "some first_name"
      assert admission.last_name == "some last_name"
      assert admission.views == 42
    end

    test "create_admission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ENR.create_admission(@invalid_attrs)
    end

    test "update_admission/2 with valid data updates the admission" do
      admission = admission_fixture()
      assert {:ok, admission} = ENR.update_admission(admission, @update_attrs)
      assert %Admission{} = admission
      assert admission.first_name == "some updated first_name"
      assert admission.last_name == "some updated last_name"
      assert admission.views == 43
    end

    test "update_admission/2 with invalid data returns error changeset" do
      admission = admission_fixture()
      assert {:error, %Ecto.Changeset{}} = ENR.update_admission(admission, @invalid_attrs)
      assert admission == ENR.get_admission!(admission.id)
    end

    test "delete_admission/1 deletes the admission" do
      admission = admission_fixture()
      assert {:ok, %Admission{}} = ENR.delete_admission(admission)
      assert_raise Ecto.NoResultsError, fn -> ENR.get_admission!(admission.id) end
    end

    test "change_admission/1 returns a admission changeset" do
      admission = admission_fixture()
      assert %Ecto.Changeset{} = ENR.change_admission(admission)
    end
  end

  describe "enrollers" do
    alias Ins.ENR.Enroller

    @valid_attrs %{gender: "some gender", role: "some role"}
    @update_attrs %{gender: "some updated gender", role: "some updated role"}
    @invalid_attrs %{gender: nil, role: nil}

    def enroller_fixture(attrs \\ %{}) do
      {:ok, enroller} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ENR.create_enroller()

      enroller
    end

    test "list_enrollers/0 returns all enrollers" do
      enroller = enroller_fixture()
      assert ENR.list_enrollers() == [enroller]
    end

    test "get_enroller!/1 returns the enroller with given id" do
      enroller = enroller_fixture()
      assert ENR.get_enroller!(enroller.id) == enroller
    end

    test "create_enroller/1 with valid data creates a enroller" do
      assert {:ok, %Enroller{} = enroller} = ENR.create_enroller(@valid_attrs)
      assert enroller.gender == "some gender"
      assert enroller.role == "some role"
    end

    test "create_enroller/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ENR.create_enroller(@invalid_attrs)
    end

    test "update_enroller/2 with valid data updates the enroller" do
      enroller = enroller_fixture()
      assert {:ok, enroller} = ENR.update_enroller(enroller, @update_attrs)
      assert %Enroller{} = enroller
      assert enroller.gender == "some updated gender"
      assert enroller.role == "some updated role"
    end

    test "update_enroller/2 with invalid data returns error changeset" do
      enroller = enroller_fixture()
      assert {:error, %Ecto.Changeset{}} = ENR.update_enroller(enroller, @invalid_attrs)
      assert enroller == ENR.get_enroller!(enroller.id)
    end

    test "delete_enroller/1 deletes the enroller" do
      enroller = enroller_fixture()
      assert {:ok, %Enroller{}} = ENR.delete_enroller(enroller)
      assert_raise Ecto.NoResultsError, fn -> ENR.get_enroller!(enroller.id) end
    end

    test "change_enroller/1 returns a enroller changeset" do
      enroller = enroller_fixture()
      assert %Ecto.Changeset{} = ENR.change_enroller(enroller)
    end
  end
end
