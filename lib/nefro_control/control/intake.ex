defmodule NefroControl.Control.Intake do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intakes" do
    field :timestamp, :utc_datetime
    field :type, :string
    field :quantity, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intake, attrs) do
    intake
    |> cast(attrs, [:quantity, :type, :timestamp])
    |> validate_required([:quantity, :type, :timestamp])
  end
end
