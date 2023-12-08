defmodule TodoLiveViewWeb.TodoLive.FormComponent do
  require Logger
  use TodoLiveViewWeb, :live_component

  alias TodoLiveView.Todos
  alias TodoLiveView.Todos.Todo

  @todos_topic "todos_topic"

  @impl true
  def update(%{todo: todo} = assigns, socket) do
    changeset = Todos.change_todo(todo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"todo" => todo_params}, socket) do
    changeset =
      socket.assigns.todo
      |> Todos.change_todo(todo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("create_todo", %{"todo" => todo_params}, socket) do
    save_todo(socket, todo_params)
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp save_todo(socket, todo_params) do
    case Todos.create_todo(todo_params) do
      {:ok, _todo} ->
        socket =
          assign(socket, items: Todos.list_todos())
          # resets the form
          |> assign(form: to_form(Todos.change_todo(%Todo{})))

        TodoLiveViewWeb.Endpoint.broadcast(@todos_topic, "todos_updated", socket.assigns)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
