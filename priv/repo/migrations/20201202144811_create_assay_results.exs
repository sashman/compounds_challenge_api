defmodule CompoundsChallengeApi.Repo.Migrations.CreateAssayResults do
  use Ecto.Migration

  def change do
    create table(:assay_results) do
      add :result_id, :integer
      add :target, :string
      add :result, :string
      add :operator, :string
      add :value, :float
      add :unit, :string
      add :compound_id, references(:compounds, on_delete: :nothing, type: :integer, column: :compound_id)

      timestamps()
    end

    create index(:assay_results, [:compound_id])
  end
end
