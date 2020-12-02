defmodule CompoundsChallengeApi.Compounds.AssayResult do
  use Ecto.Schema
  alias CompoundsChallengeApi.Compounds.Compound
  import Ecto.Changeset

  @primary_key {:result_id, :integer, []}
  schema "assay_results" do
    field :operator, :string
    field :result, :string
    field :target, :string
    field :unit, :string
    field :value, :float
    field :compound_id, :integer

    belongs_to :compound, Compound,
      define_field: false,
      foreign_key: :compound_id,
      references: :compound_id

    timestamps()
  end

  @doc false
  def changeset(assay_result, attrs) do
    assay_result
    |> cast(attrs, [:result_id, :target, :compound_id, :result, :operator, :value, :unit])
    |> validate_required([:result_id, :compound_id, :target, :result, :operator, :value, :unit])
    |> assoc_constraint(:compound)
    |> foreign_key_constraint(:compound_id)
    |> unique_constraint(:result_id)
  end
end
