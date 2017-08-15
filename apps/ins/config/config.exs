use Mix.Config

config :ins, ecto_repos: [Ins.Repo]

import_config "#{Mix.env}.exs"
