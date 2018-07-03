use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app_api, AppApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :app_api, AppApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "app_api_test",
  hostname: "app_api_db",
  pool: Ecto.Adapters.SQL.Sandbox

config :app_api, ewallet: [
    base_url: "http://ewallet:4000/",
    api_key: "",
    access_key: "",
    secret_key: ""
  ]

# test config for bcrypt, so we don't slow things down while testing
config :bcrypt_elixir, :log_rounds, 4
