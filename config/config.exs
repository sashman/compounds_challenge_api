# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :compounds_challenge_api,
  ecto_repos: [CompoundsChallengeApi.Repo]

# Configures the endpoint
config :compounds_challenge_api, CompoundsChallengeApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AOLC2H9XV0yOlNYML2fyGelYzpyfJDDsyFldSB49UR0kVzc7CkkZz+cMew4IWVVS",
  render_errors: [view: CompoundsChallengeApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CompoundsChallengeApi.PubSub,
  live_view: [signing_salt: "WGfDel8s"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
