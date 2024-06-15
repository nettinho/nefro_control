defmodule NefroControl.Repo.Migrations.CreateOutputs do
  use Ecto.Migration

  def change do
    create table(:outputs) do
      add :quantity, :float
      add :type, :string
      add :comments, :text
      add :timestamp, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
