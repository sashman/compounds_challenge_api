defmodule CompoundsChallengeApiWeb.AssayResultView do
  use CompoundsChallengeApiWeb, :view
  alias CompoundsChallengeApiWeb.AssayResultView

  def render("index.json", %{assay_results: assay_results}) do
    %{data: render_many(assay_results, AssayResultView, "assay_result.json")}
  end

  def render("show.json", %{assay_result: assay_result}) do
    %{data: render_one(assay_result, AssayResultView, "assay_result.json")}
  end

  def render("assay_result.json", %{assay_result: assay_result}) do
    mapped(assay_result)
  end

  def mapped(assay_result) do
    %{
      result_id: assay_result.result_id,
      target: assay_result.target,
      result: assay_result.result,
      operator: assay_result.operator,
      value: assay_result.value,
      unit: assay_result.unit
    }
  end
end
