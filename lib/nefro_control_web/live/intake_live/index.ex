defmodule NefroControlWeb.IntakeLive.Index do
  use NefroControlWeb, :live_view

  alias NefroControl.Control
  alias NefroControl.Control.Intake

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :intakes, Control.list_intakes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Intake")
    |> assign(:intake, Control.get_intake!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Intake")
    |> assign(:intake, %Intake{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Intakes")
    |> assign(:intake, nil)
  end

  @impl true
  def handle_info({NefroControlWeb.IntakeLive.FormComponent, {:saved, intake}}, socket) do
    {:noreply, stream_insert(socket, :intakes, intake)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    intake = Control.get_intake!(id)
    {:ok, _} = Control.delete_intake(intake)

    {:noreply, stream_delete(socket, :intakes, intake)}
  end
end
