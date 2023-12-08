# TodoLiveView

A simple TodoList application in Elixir, built with **Phoenix 1.7.7** and **LiveView 0.19.0**
which are the latest versions included, as of December 2023, when generating a new application
with the command:

```
mix phx.new todo_live_view

```

This application is heavily inspired this tutorial:

https://dev.to/collinewait/how-to-build-a-phoenix-liveview-todo-list-app-with-testing-29n4,

Basically it's an upgrade of that tutorial, originally implemented with Phoenix 1.6.14 and LiveView 0.17.5

The main differences are:

- different layout for live views folders (e.g. `lib/todo_live_view_web/live/todo_live` instead of `lib/todo_live_view_web/live`)
- different usage of live view components (e.g. `<.input type="checkbox" ...` instead of `<%= checkbox(... ` )
- styled with Tailwind

## Development

### Prerequisites
1. You need Elixir, Mix and Phoenix installed.

    See: https://hexdocs.pm/phoenix/installation.html

2. Then, you need a Postgres db to store your to-dos.

    A docker-compose.yml file has been added to the project to launch a Postgres instance locally.

    - Launch it with `docker-compose up -d`
    - Log into the pgAdmin console http://localhost:5050 and create 2 new databases:
        - `todo_live_view_dev`
        - `todo_live_view_test`


### Start Phoenix
To start your Phoenix server:

- Run `mix setup` to install and setup dependencies

- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
