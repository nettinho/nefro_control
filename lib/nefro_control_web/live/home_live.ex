defmodule NefroControlWeb.HomeLive do
  use NefroControlWeb, :live_view

  alias NefroControl.Control

  @impl true
  def mount(_params, _session, socket) do
    {:ok, refresh(socket)}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info({NefroControlWeb.IntakeModal, _}, socket) do
    {:noreply, refresh(socket)}
  end

  @impl true
  def handle_info({NefroControlWeb.OutputModal, _}, socket) do
    {:noreply, refresh(socket)}
  end

  defp refresh(socket) do
    intake_ml =
      Date.utc_today()
      |> Control.list_intakes_by_date()
      |> Enum.map(& &1.quantity)
      |> Enum.sum()
      |> ceil()

    output_ml =
      Date.utc_today()
      |> Control.list_outputs_by_date()
      |> Enum.map(& &1.quantity)
      |> Enum.sum()
      |> ceil()

    assign(socket,
      intake_pct: intake_pct(intake_ml),
      intake_ml: intake_ml,
      output_pct: output_pct(output_ml, intake_ml),
      output_ml: output_ml
    )
  end

  defp intake_pct(ml) do
    ceil(ml / 3000 * 100)
  end

  defp output_pct(_, 0) do
    0
  end

  defp output_pct(output_ml, intake_ml) do
    ceil(output_ml / intake_ml * 100)
  end

  def handle_event("window", params, socket) do
    dbg({:window, params})
    {:noreply, socket}
  end
end
