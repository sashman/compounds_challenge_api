defmodule CompoundsChallengeApi.Repo.Migrations.CreateCompounds do
  use Ecto.Migration

  def change do
    create table(:compounds) do
      add :compound_id, :integer
      add :smiles, :string
      add :molecular_weight, :float
      add :molecular_formula, :string
      add :num_rings, :integer
      add :image_path, :string

      timestamps()
    end

  end
end
