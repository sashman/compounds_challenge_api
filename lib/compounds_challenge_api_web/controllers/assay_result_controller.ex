defmodule CompoundsChallengeApiWeb.AssayResultController do
  use CompoundsChallengeApiWeb, :controller

  alias CompoundsChallengeApi.Compounds
  alias CompoundsChallengeApi.Compounds.AssayResult

  action_fallback CompoundsChallengeApiWeb.FallbackController

  def index(conn, _params) do
    assay_results = Compounds.list_assay_results()
    render(conn, "index.json", assay_results: assay_results)
  end

  def create(conn, %{"assay_result" => assay_result_params}) do
    with {:ok, %AssayResult{} = assay_result} <- Compounds.create_assay_result(assay_result_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.assay_result_path(conn, :show, assay_result))
      |> render("show.json", assay_result: assay_result)
    end
  end

  def show(conn, %{"id" => id}) do
    assay_result = Compounds.get_assay_result!(id)
    render(conn, "show.json", assay_result: assay_result)
  end

  def update(conn, %{"id" => id, "assay_result" => assay_result_params}) do
    assay_result = Compounds.get_assay_result!(id)

    with {:ok, %AssayResult{} = assay_result} <- Compounds.update_assay_result(assay_result, assay_result_params) do
      render(conn, "show.json", assay_result: assay_result)
    end
  end

  def delete(conn, %{"id" => id}) do
    assay_result = Compounds.get_assay_result!(id)

    with {:ok, %AssayResult{}} <- Compounds.delete_assay_result(assay_result) do
      send_resp(conn, :no_content, "")
    end
  end
end
