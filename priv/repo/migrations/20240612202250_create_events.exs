defmodule NefroControl.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :comments, :text
      add :timestamp, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
