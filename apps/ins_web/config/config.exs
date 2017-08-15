# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ins_web,
  namespace: InsWeb,
  ecto_repos: [Ins.Repo]

# Configures the endpoint
config :ins_web, InsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8uqk5wxn/9RPkAYf5aXxp9zansGZzxhP6fxJdf73XqDhFfCZiKZAoYEZqOO8doPx",
  render_errors: [view: InsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: InsWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ins_web, :generators,
  context_app: :ins

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
