defmodule NefroControlWeb.OutputModal do
  use NefroControlWeb, :live_component

  alias NefroControl.Control
  alias NefroControl.Control.Output

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="mb-2 font-bold">Apuntar desague</div>
      <.simple_form
        for={@form}
        id="output-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <ul class="flex w-full gap-4 items-center">
          <li>
            <input type="radio" class="hidden peer" checked={@type == "bladder"} />
            <label phx-click="type-bladder" phx-target={@myself} for="type_bladder" class={~w(
                inline-flex p-5
                items-center justify-between
                text-gray-500 bg-white
                border-2 border-gray-200 rounded-lg cursor-pointer
                dark:hover:text-gray-300 dark:border-gray-700 dark:peer-checked:text-blue-500
                peer-checked:border-blue-600 peer-checked:text-blue-600
                hover:text-gray-600 hover:bg-gray-100 dark:text-gray-400
                dark:bg-gray-800 dark:hover:bg-gray-700
              )}>
              <img class="w-full" src="/images/bladder.svg" />
            </label>
          </li>
          <li>
            <input type="radio" class="hidden peer" checked={@type == "nephrostomy"} />
            <label phx-click="type-nephrostomy" phx-target={@myself} for="type_nephrostomy" class={~w(
                inline-flex p-5
                items-center justify-between
                text-gray-500 bg-white
                border-2 border-gray-200 rounded-lg cursor-pointer
                dark:hover:text-gray-300 dark:border-gray-700 dark:peer-checked:text-blue-500
                peer-checked:border-blue-600 peer-checked:text-blue-600
                hover:text-gray-600 hover:bg-gray-100 dark:text-gray-400
                dark:bg-gray-800 dark:hover:bg-gray-700
              )}>
              <img class="w-full" src="/images/nephrostomy.png" />
            </label>
          </li>
        </ul>

        <.input field={@form[:quantity]} type="number" label="Cantidad (ml) *" step="any" />
        <.input field={@form[:comments]} type="textarea" label="Comentarios" />
        <:actions>
          <.button phx-disable-with="Guardando..." class="w-full">Guardar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(_assigns, socket) do
    changeset = Control.change_output(%Output{})

    {:ok,
     socket
     |> assign(:type, "bladder")
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"output" => output_params}, socket) do
    changeset =
      %Output{}
      |> Control.change_output(output_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"output" => params}, socket) do
    params =
      params
      |> Map.put("timestamp", DateTime.utc_now())
      |> Map.put("type", socket.assigns.type)
      |> dbg

    case Control.create_output(params) |> dbg do
      {:ok, output} ->
        notify_parent({:saved, output})

        {:noreply,
         socket
         |> put_flash(:info, "Desague apuntado!")
         |> push_patch(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  def handle_event("type-bladder", _, socket) do
    {:noreply, assign(socket, :type, "bladder")}
  end

  def handle_event("type-nephrostomy", _, socket) do
    {:noreply, assign(socket, :type, "nephrostomy")}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
