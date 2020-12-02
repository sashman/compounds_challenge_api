defmodule CompoundsChallengeApiWeb.CompoundController do
  use CompoundsChallengeApiWeb, :controller

  alias CompoundsChallengeApi.Compounds
  alias CompoundsChallengeApi.Compounds.Compound

  action_fallback CompoundsChallengeApiWeb.FallbackController

  def index(conn, _params) do
    compounds = Compounds.list_compounds()
    render(conn, "index.json", compounds: compounds)
  end

  def create(conn, %{"compound" => compound_params}) do
    with {:ok, %Compound{} = compound} <- Compounds.create_compound(compound_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.compound_path(conn, :show, compound))
      |> render("show.json", compound: compound)
    end
  end

  def show(conn, %{"id" => id}) do
    compound = Compounds.get_compound!(id)
    render(conn, "show.json", compound: compound)
  end

  def update(conn, %{"id" => id, "compound" => compound_params}) do
    compound = Compounds.get_compound!(id)

    with {:ok, %Compound{} = compound} <- Compounds.update_compound(compound, compound_params) do
      render(conn, "show.json", compound: compound)
    end
  end

  def delete(conn, %{"id" => id}) do
    compound = Compounds.get_compound!(id)

    with {:ok, %Compound{}} <- Compounds.delete_compound(compound) do
      send_resp(conn, :no_content, "")
    end
  end
end
