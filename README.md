# ToDoList

To-do list application with some social features.

## Getting Started

### Prerequisites

  * Erlang: http://erlang.org/doc/installation_guide/INSTALL.html
  * Elixir: https://elixir-lang.org/install.html
  * Phoenix: https://hexdocs.pm/phoenix/installation.html
  * Node and npm: https://nodejs.org/en/download/
  * Postgres: https://www.postgresql.org/download/

#### Alternatives
  
  * Install erlang and elixir with [asdf](https://github.com/asdf-vm/asdf). Mint 19 [gist](https://gist.github.com/paulorsouza/ce86c918721444738d75429f4a505059).
  * Install postgres with [Docker](https://www.docker.com/). [Gist](https://gist.github.com/paulorsouza/214de39e122c19c231ab92a9dc7669e4).


### Install

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * You can run seed to initial data `mix run priv/repo/seeds.exs`

### Development

  * Start Phoenix endpoint with `mix phx.server`

    Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Unit tests

  * running backend tests with `mix test`
  * running frontend tests with `cd assets && npm test`
  * Recover account test doesn't run by default, because this test realy send email to user. So, to run this test you need pass `'--include'` or `'--only'` to `'mix test'`.
  * `mix test --include need_network` or `mix test --only need_network`

### Acceptance tests

  * install [Selenium 3.5.0](https://selenium-release.storage.googleapis.com/index.html?path=3.5/)
  * run selenium `java -jar selenium-server-standalone-3.5.0.jar`
  * run tests with compile assets `mix test.acceptance`
  * compile assets before run tests `cd assets && node node_modules/webpack/bin/webpack.js --mode production && cd ..`
  * `mix test --only acceptance`

  Obs: 
    
    * Acceptance test #US09 need internet to pass, because fontawesome icon is a target.
  
    * Acceptance teste #US08 need internet to pass, because send email.