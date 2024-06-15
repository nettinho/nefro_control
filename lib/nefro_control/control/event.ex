defmodule NefroControl.Control.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :timestamp, :utc_datetime
    field :comments, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:comments, :timestamp])
    |> validate_required([:comments, :timestamp])
  end
end
