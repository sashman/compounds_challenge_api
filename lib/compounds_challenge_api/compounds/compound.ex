defmodule CompoundsChallengeApi.Compounds.Compound do
  use Ecto.Schema
  alias CompoundsChallengeApi.Compounds.AssayResult
  import Ecto.Changeset

  @primary_key {:compound_id, :integer, []}
  schema "compounds" do
    field :image_path, :string
    field :molecular_formula, :string
    field :molecular_weight, :float
    field :num_rings, :integer
    field :smiles, :string
    field :alogp, :float
    has_many :assay_results, AssayResult, foreign_key: :compound_id, references: :compound_id

    timestamps()
  end

  @doc false
  def changeset(compound, attrs) do
    compound
    |> cast(attrs, [
      :compound_id,
      :smiles,
      :molecular_weight,
      :molecular_formula,
      :num_rings,
      :image_path
    ])
    |> validate_required([
      :compound_id,
      :smiles,
      :molecular_weight,
      :molecular_formula,
      :num_rings,
      :image_path
    ])
    |> unique_constraint(:compound_id)
  end
end
