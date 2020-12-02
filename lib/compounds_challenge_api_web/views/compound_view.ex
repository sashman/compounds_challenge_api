defmodule CompoundsChallengeApiWeb.CompoundView do
  use CompoundsChallengeApiWeb, :view
  alias CompoundsChallengeApiWeb.{CompoundView, AssayResultView}

  def render("index.json", %{compounds: compounds}) do
    %{data: render_many(compounds, CompoundView, "compound.json")}
  end

  def render("show.json", %{compound: compound}) do
    %{data: render_one(compound, CompoundView, "compound.json")}
  end

  def render("compound.json", %{compound: compound}) do
    %{
      compound_id: compound.compound_id,
      smiles: compound.smiles,
      molecular_weight: compound.molecular_weight,
      molecular_formula: compound.molecular_formula,
      num_rings: compound.num_rings,
      image_path: compound.image_path
    }
    |> append_assay_results(compound)
  end

  defp append_assay_results(map, %{assay_results: assay_results})
       when is_list(assay_results) do
    Map.put(
      map,
      :assay_results,
      for assay_result <- assay_results do
        AssayResultView.mapped(assay_result)
      end
    )
  end

  defp append_assay_results(map, _), do: map
end
