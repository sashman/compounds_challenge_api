defmodule CompoundsChallengeApi.Repo do
  use Ecto.Repo,
    otp_app: :compounds_challenge_api,
    adapter: Ecto.Adapters.Postgres
end
