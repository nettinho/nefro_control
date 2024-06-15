defmodule NefroControlWeb.IntakeLiveTest do
  use NefroControlWeb.ConnCase

  import Phoenix.LiveViewTest
  import NefroControl.ControlFixtures

  @create_attrs %{timestamp: "2024-06-11T20:22:00Z", type: "some type", quantity: 120.5}
  @update_attrs %{timestamp: "2024-06-12T20:22:00Z", type: "some updated type", quantity: 456.7}
  @invalid_attrs %{timestamp: nil, type: nil, quantity: nil}

  defp create_intake(_) do
    intake = intake_fixture()
    %{intake: intake}
  end

  describe "Index" do
    setup [:create_intake]

    test "lists all intakes", %{conn: conn, intake: intake} do
      {:ok, _index_live, html} = live(conn, ~p"/intakes")

      assert html =~ "Listing Intakes"
      assert html =~ intake.type
    end

    test "saves new intake", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/intakes")

      assert index_live |> element("a", "New Intake") |> render_click() =~
               "New Intake"

      assert_patch(index_live, ~p"/intakes/new")

      assert index_live
             |> form("#intake-form", intake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#intake-form", intake: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/intakes")

      html = render(index_live)
      assert html =~ "Intake created successfully"
      assert html =~ "some type"
    end

    test "updates intake in listing", %{conn: conn, intake: intake} do
      {:ok, index_live, _html} = live(conn, ~p"/intakes")

      assert index_live |> element("#intakes-#{intake.id} a", "Edit") |> render_click() =~
               "Edit Intake"

      assert_patch(index_live, ~p"/intakes/#{intake}/edit")

      assert index_live
             |> form("#intake-form", intake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#intake-form", intake: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/intakes")

      html = render(index_live)
      assert html =~ "Intake updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes intake in listing", %{conn: conn, intake: intake} do
      {:ok, index_live, _html} = live(conn, ~p"/intakes")

      assert index_live |> element("#intakes-#{intake.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#intakes-#{intake.id}")
    end
  end

  describe "Show" do
    setup [:create_intake]

    test "displays intake", %{conn: conn, intake: intake} do
      {:ok, _show_live, html} = live(conn, ~p"/intakes/#{intake}")

      assert html =~ "Show Intake"
      assert html =~ intake.type
    end

    test "updates intake within modal", %{conn: conn, intake: intake} do
      {:ok, show_live, _html} = live(conn, ~p"/intakes/#{intake}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Intake"

      assert_patch(show_live, ~p"/intakes/#{intake}/show/edit")

      assert show_live
             |> form("#intake-form", intake: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#intake-form", intake: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/intakes/#{intake}")

      html = render(show_live)
      assert html =~ "Intake updated successfully"
      assert html =~ "some updated type"
    end
  end
end
