defmodule NefroControlWeb.IntakeLive.FormComponent do
  use NefroControlWeb, :live_component

  alias NefroControl.Control

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage intake records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="intake-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:quantity]} type="number" label="Quantity" step="any" />
        <.input field={@form[:type]} type="text" label="Type" />
        <.input field={@form[:timestamp]} type="datetime-local" label="Timestamp" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Intake</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{intake: intake} = assigns, socket) do
    changeset = Control.change_intake(intake)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"intake" => intake_params}, socket) do
    changeset =
      socket.assigns.intake
      |> Control.change_intake(intake_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"intake" => intake_params}, socket) do
    save_intake(socket, socket.assigns.action, intake_params)
  end

  defp save_intake(socket, :edit, intake_params) do
    case Control.update_intake(socket.assigns.intake, intake_params) do
      {:ok, intake} ->
        notify_parent({:saved, intake})

        {:noreply,
         socket
         |> put_flash(:info, "Intake updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_intake(socket, :new, intake_params) do
    case Control.create_intake(intake_params) do
      {:ok, intake} ->
        notify_parent({:saved, intake})

        {:noreply,
         socket
         |> put_flash(:info, "Intake created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
