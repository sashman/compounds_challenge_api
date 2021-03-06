defmodule CompoundsChallengeApiWeb.AssayResultControllerTest do
  use CompoundsChallengeApiWeb.ConnCase

  alias CompoundsChallengeApi.Compounds
  alias CompoundsChallengeApi.Compounds.AssayResult

  @create_attrs %{
    operator: "some operator",
    result: "some result",
    result_id: 42,
    target: "some target",
    unit: "some unit",
    value: 120.5
  }
  @update_attrs %{
    operator: "some updated operator",
    result: "some updated result",
    result_id: 43,
    target: "some updated target",
    unit: "some updated unit",
    value: 456.7
  }
  @invalid_attrs %{operator: nil, result: nil, result_id: nil, target: nil, unit: nil, value: nil}

  def fixture(:assay_result) do
    {:ok, assay_result} = Compounds.create_assay_result(@create_attrs)
    assay_result
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all assay_results", %{conn: conn} do
      conn = get(conn, Routes.assay_result_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create assay_result" do
    test "renders assay_result when data is valid", %{conn: conn} do
      conn = post(conn, Routes.assay_result_path(conn, :create), assay_result: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.assay_result_path(conn, :show, id))

      assert %{
               "id" => id,
               "operator" => "some operator",
               "result" => "some result",
               "result_id" => 42,
               "target" => "some target",
               "unit" => "some unit",
               "value" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assay_result_path(conn, :create), assay_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update assay_result" do
    setup [:create_assay_result]

    test "renders assay_result when data is valid", %{conn: conn, assay_result: %AssayResult{id: id} = assay_result} do
      conn = put(conn, Routes.assay_result_path(conn, :update, assay_result), assay_result: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.assay_result_path(conn, :show, id))

      assert %{
               "id" => id,
               "operator" => "some updated operator",
               "result" => "some updated result",
               "result_id" => 43,
               "target" => "some updated target",
               "unit" => "some updated unit",
               "value" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, assay_result: assay_result} do
      conn = put(conn, Routes.assay_result_path(conn, :update, assay_result), assay_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete assay_result" do
    setup [:create_assay_result]

    test "deletes chosen assay_result", %{conn: conn, assay_result: assay_result} do
      conn = delete(conn, Routes.assay_result_path(conn, :delete, assay_result))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.assay_result_path(conn, :show, assay_result))
      end
    end
  end

  defp create_assay_result(_) do
    assay_result = fixture(:assay_result)
    %{assay_result: assay_result}
  end
end
