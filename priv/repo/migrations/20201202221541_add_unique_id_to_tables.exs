defmodule CompoundsChallengeApi.Repo.Migrations.AddUniqueIdToTables do
  use Ecto.Migration

  def change do
    create unique_index(:assay_results, [:result_id])
  end
end
