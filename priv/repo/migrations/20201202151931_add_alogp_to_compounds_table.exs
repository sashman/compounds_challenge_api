defmodule CompoundsChallengeApi.Repo.Migrations.AddAlogpToCompoundsTable do
  use Ecto.Migration

  def change do
    alter table("compounds") do
      add :alogp, :float
    end
  end
end
