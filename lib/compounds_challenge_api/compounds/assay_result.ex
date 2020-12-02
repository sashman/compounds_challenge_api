defmodule CompoundsChallengeApi.Compounds.AssayResult do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assay_results" do
    field :operator, :string
    field :result, :string
    field :result_id, :integer
    field :target, :string
    field :unit, :string
    field :value, :float
    field :compound_id, :id

    timestamps()
  end

  @doc false
  def changeset(assay_result, attrs) do
    assay_result
    |> cast(attrs, [:result_id, :target, :result, :operator, :value, :unit])
    |> validate_required([:result_id, :target, :result, :operator, :value, :unit])
  end
end
