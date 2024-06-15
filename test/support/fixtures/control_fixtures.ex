defmodule NefroControl.ControlFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NefroControl.Control` context.
  """

  @doc """
  Generate a intake.
  """
  def intake_fixture(attrs \\ %{}) do
    {:ok, intake} =
      attrs
      |> Enum.into(%{
        quantity: 120.5,
        timestamp: ~U[2024-06-11 20:22:00Z],
        type: "some type"
      })
      |> NefroControl.Control.create_intake()

    intake
  end

  @doc """
  Generate a output.
  """
  def output_fixture(attrs \\ %{}) do
    {:ok, output} =
      attrs
      |> Enum.into(%{
        comments: "some comments",
        quantity: 120.5,
        timestamp: ~U[2024-06-11 20:22:00Z],
        type: "some type"
      })
      |> NefroControl.Control.create_output()

    output
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        comments: "some comments",
        timestamp: ~U[2024-06-11 20:22:00Z]
      })
      |> NefroControl.Control.create_event()

    event
  end
end
