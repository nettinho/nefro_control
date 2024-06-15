defmodule NefroControlWeb.IntakeModal do
  use NefroControlWeb, :live_component

  alias NefroControl.Control
  alias NefroControl.Control.Intake

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="mb-4 font-bold">Apuntar hidratación</div>
      <button
        phx-click="botella350"
        phx-target={@myself}
        type="button"
        class="text-white bg-gradient-to-r from-pink-400 via-pink-500 to-pink-600 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-pink-300 dark:focus:ring-pink-800 shadow-lg shadow-pink-500/50 dark:shadow-lg dark:shadow-pink-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2"
      >
        Botella 350ml
      </button>
      <button
        phx-click="botella750"
        phx-target={@myself}
        type="button"
        class="text-white bg-gradient-to-r from-cyan-400 via-cyan-500 to-cyan-600 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-cyan-300 dark:focus:ring-cyan-800 shadow-lg shadow-cyan-500/50 dark:shadow-lg dark:shadow-cyan-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2"
      >
        Botella 750ml
      </button>

      <div class="border-t text-center py-4 mt-4 font-bold text-lg">Otro formato</div>
      <.simple_form
        for={@form}
        id="intake-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:quantity]} type="number" label="Cantidad (ml)" step="any" />
        <.input field={@form[:type]} type="text" label="Formato" />
        <:actions>
          <.button phx-disable-with="Guardando..." class="w-full">Guardar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(_assigns, socket) do
    changeset = Control.change_intake(%Intake{})

    {:ok, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("validate", %{"intake" => intake_params}, socket) do
    changeset =
      %Intake{}
      |> Control.change_intake(intake_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"intake" => intake_params}, socket) do
    save(socket, Map.put(intake_params, "timestamp", DateTime.utc_now()))
  end

  def handle_event("botella350", _, socket) do
    save(socket, %{
      quantity: 350,
      type: "Botella 350ml",
      timestamp: DateTime.utc_now()
    })
  end

  def handle_event("botella750", _, socket) do
    save(socket, %{
      quantity: 750,
      type: "Botella 750ml",
      timestamp: DateTime.utc_now()
    })
  end

  defp save(socket, params) do
    case Control.create_intake(params) do
      {:ok, intake} ->
        notify_parent({:saved, intake})

        {:noreply,
         socket
         |> put_flash(:info, "Hidratación apuntada!")
         |> push_patch(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
