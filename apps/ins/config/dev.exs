use Mix.Config

# Configure your database
config :ins, Ins.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ins_dev",
  hostname: "localhost",
  pool_size: 10
