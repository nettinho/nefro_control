defmodule NefroControl.Repo.Migrations.CreateIntakes do
  use Ecto.Migration

  def change do
    create table(:intakes) do
      add :quantity, :float
      add :type, :string
      add :timestamp, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
