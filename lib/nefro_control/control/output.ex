defmodule NefroControl.Control.Output do
  use Ecto.Schema
  import Ecto.Changeset

  schema "outputs" do
    field :timestamp, :utc_datetime
    field :type, :string
    field :comments, :string
    field :quantity, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(output, attrs) do
    output
    |> cast(attrs, [:quantity, :type, :comments, :timestamp])
    |> validate_required([:quantity, :type, :timestamp])
  end
end
