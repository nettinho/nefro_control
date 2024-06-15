defmodule NefroControlWeb.OutputLive.FormComponent do
  use NefroControlWeb, :live_component

  alias NefroControl.Control

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage output records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="output-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:quantity]} type="number" label="Quantity" step="any" />
        <.input field={@form[:type]} type="text" label="Type" />
        <.input field={@form[:comments]} type="text" label="Comments" />
        <.input field={@form[:timestamp]} type="datetime-local" label="Timestamp" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Output</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{output: output} = assigns, socket) do
    changeset = Control.change_output(output)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"output" => output_params}, socket) do
    changeset =
      socket.assigns.output
      |> Control.change_output(output_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"output" => output_params}, socket) do
    save_output(socket, socket.assigns.action, output_params)
  end

  defp save_output(socket, :edit, output_params) do
    case Control.update_output(socket.assigns.output, output_params) do
      {:ok, output} ->
        notify_parent({:saved, output})

        {:noreply,
         socket
         |> put_flash(:info, "Output updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_output(socket, :new, output_params) do
    case Control.create_output(output_params) do
      {:ok, output} ->
        notify_parent({:saved, output})

        {:noreply,
         socket
         |> put_flash(:info, "Output created successfully")
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
