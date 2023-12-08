defmodule TodoLiveViewWeb.TodoLiveTest do
  use TodoLiveViewWeb.ConnCase

  import Phoenix.LiveViewTest
  import TodoLiveView.TodosFixtures

  alias TodoLiveView.Todos

  defp create_todo(_) do
    todo = todo_fixture()
    %{todo: todo}
  end

  describe "Index" do
    setup [:create_todo]

    test "lists all todos", %{conn: conn, todo: todo} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Todos"
      assert html =~ todo.text
    end

    test "saves new todo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      index_live
      |> form("#todo-form", %{
        "todo[text]" => "some text"
      })
      |> render_submit()

      html = render(index_live)
      assert html =~ "some text"

      index_live
      |> form("#todo-form", %{
        "todo[text]" => nil
      })
      |> render_submit()

      html = render(index_live)
      assert html =~ "can&#39;t be blank"
    end

    test "deletes todo in listing", %{conn: conn, todo: todo} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      assert index_live |> element("a#todo-#{todo.id}", "Delete") |> render_click()
      refute has_element?(index_live, "#todos-#{todo.id}")
    end
  end

  describe "Toggle" do
    test "toggle todo item", %{conn: conn} do
      {:ok, todo} = Todos.create_todo(%{"text" => "first item"})
      assert todo.completed == false

      {:ok, view, _html} = live(conn, "/")

      assert view |> element("tbody#todos > tr > td", "first item") |> render_click() =~
               "completed"

      updated_todo = Todos.get_todo!(todo.id)
      assert updated_todo.completed == true
    end
  end
end
