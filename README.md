# Phoenix Services Backend

# Phoenix
[Phoenix Framework](http://phoenixframework.org/) leverages the Erlang VM ability to handle millions of connections alongside Elixir's beautiful syntax and productive tooling for building fault-tolerant systems.

The Phoneix Services Backend manages all communications with our [Electron Frontend](https://github.com/blocplay/frontend). Our Phoenix Services Backend currently communicates & relays with our [eWallet Backend](https://github.com/blocplay/ewallet) as well as our [Blockchain Services Backend](https://github.com/blocplay/blockchain-services).

All source code is released as is under the Apache v2 licensing.

# Setup

To setup the Phoneix Services Backend you will need to configure your services.

## Configure your database
```
config :app_api, AppApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "app_api_dev",
  hostname: "app_api_db",
  pool_size: 10
```

## Configure your eWallet API Access:
````
config :app_api, ewallet: [
    base_url: "http://ewallet:4000/",
    api_key: "",
    access_key: "",
    secret_key: ""
  ]
````

## Configure your Blockchain Integration Services API Access:
````
config :app_api, blockchain: [
    base_url: ""
  ]
````

# Launching

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
