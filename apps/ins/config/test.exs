use Mix.Config

# Configure your database
config :ins, Ins.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ins_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
