defmodule NefroControlWeb.OutputLiveTest do
  use NefroControlWeb.ConnCase

  import Phoenix.LiveViewTest
  import NefroControl.ControlFixtures

  @create_attrs %{timestamp: "2024-06-11T20:22:00Z", type: "some type", comments: "some comments", quantity: 120.5}
  @update_attrs %{timestamp: "2024-06-12T20:22:00Z", type: "some updated type", comments: "some updated comments", quantity: 456.7}
  @invalid_attrs %{timestamp: nil, type: nil, comments: nil, quantity: nil}

  defp create_output(_) do
    output = output_fixture()
    %{output: output}
  end

  describe "Index" do
    setup [:create_output]

    test "lists all outputs", %{conn: conn, output: output} do
      {:ok, _index_live, html} = live(conn, ~p"/outputs")

      assert html =~ "Listing Outputs"
      assert html =~ output.type
    end

    test "saves new output", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/outputs")

      assert index_live |> element("a", "New Output") |> render_click() =~
               "New Output"

      assert_patch(index_live, ~p"/outputs/new")

      assert index_live
             |> form("#output-form", output: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#output-form", output: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/outputs")

      html = render(index_live)
      assert html =~ "Output created successfully"
      assert html =~ "some type"
    end

    test "updates output in listing", %{conn: conn, output: output} do
      {:ok, index_live, _html} = live(conn, ~p"/outputs")

      assert index_live |> element("#outputs-#{output.id} a", "Edit") |> render_click() =~
               "Edit Output"

      assert_patch(index_live, ~p"/outputs/#{output}/edit")

      assert index_live
             |> form("#output-form", output: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#output-form", output: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/outputs")

      html = render(index_live)
      assert html =~ "Output updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes output in listing", %{conn: conn, output: output} do
      {:ok, index_live, _html} = live(conn, ~p"/outputs")

      assert index_live |> element("#outputs-#{output.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#outputs-#{output.id}")
    end
  end

  describe "Show" do
    setup [:create_output]

    test "displays output", %{conn: conn, output: output} do
      {:ok, _show_live, html} = live(conn, ~p"/outputs/#{output}")

      assert html =~ "Show Output"
      assert html =~ output.type
    end

    test "updates output within modal", %{conn: conn, output: output} do
      {:ok, show_live, _html} = live(conn, ~p"/outputs/#{output}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Output"

      assert_patch(show_live, ~p"/outputs/#{output}/show/edit")

      assert show_live
             |> form("#output-form", output: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#output-form", output: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/outputs/#{output}")

      html = render(show_live)
      assert html =~ "Output updated successfully"
      assert html =~ "some updated type"
    end
  end
end
