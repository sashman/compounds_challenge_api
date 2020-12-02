defmodule CompoundsChallengeApi.Compounds.Compound do
  use Ecto.Schema
  import Ecto.Changeset

  schema "compounds" do
    field :compound_id, :integer
    field :image_path, :string
    field :molecular_formula, :string
    field :molecular_weight, :float
    field :num_rings, :integer
    field :smiles, :string

    timestamps()
  end

  @doc false
  def changeset(compound, attrs) do
    compound
    |> cast(attrs, [:compound_id, :smiles, :molecular_weight, :molecular_formula, :num_rings, :image_path])
    |> validate_required([:compound_id, :smiles, :molecular_weight, :molecular_formula, :num_rings, :image_path])
  end
end
