defmodule NefroControlWeb.OutputLive.Index do
  use NefroControlWeb, :live_view

  alias NefroControl.Control
  alias NefroControl.Control.Output

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :outputs, Control.list_outputs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Output")
    |> assign(:output, Control.get_output!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Output")
    |> assign(:output, %Output{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Outputs")
    |> assign(:output, nil)
  end

  @impl true
  def handle_info({NefroControlWeb.OutputLive.FormComponent, {:saved, output}}, socket) do
    {:noreply, stream_insert(socket, :outputs, output)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    output = Control.get_output!(id)
    {:ok, _} = Control.delete_output(output)

    {:noreply, stream_delete(socket, :outputs, output)}
  end
end
