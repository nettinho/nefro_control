defmodule NefroControl.ControlTest do
  use NefroControl.DataCase

  alias NefroControl.Control

  describe "intakes" do
    alias NefroControl.Control.Intake

    import NefroControl.ControlFixtures

    @invalid_attrs %{timestamp: nil, type: nil, quantity: nil}

    test "list_intakes/0 returns all intakes" do
      intake = intake_fixture()
      assert Control.list_intakes() == [intake]
    end

    test "get_intake!/1 returns the intake with given id" do
      intake = intake_fixture()
      assert Control.get_intake!(intake.id) == intake
    end

    test "create_intake/1 with valid data creates a intake" do
      valid_attrs = %{timestamp: ~U[2024-06-11 20:22:00Z], type: "some type", quantity: 120.5}

      assert {:ok, %Intake{} = intake} = Control.create_intake(valid_attrs)
      assert intake.timestamp == ~U[2024-06-11 20:22:00Z]
      assert intake.type == "some type"
      assert intake.quantity == 120.5
    end

    test "create_intake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Control.create_intake(@invalid_attrs)
    end

    test "update_intake/2 with valid data updates the intake" do
      intake = intake_fixture()
      update_attrs = %{timestamp: ~U[2024-06-12 20:22:00Z], type: "some updated type", quantity: 456.7}

      assert {:ok, %Intake{} = intake} = Control.update_intake(intake, update_attrs)
      assert intake.timestamp == ~U[2024-06-12 20:22:00Z]
      assert intake.type == "some updated type"
      assert intake.quantity == 456.7
    end

    test "update_intake/2 with invalid data returns error changeset" do
      intake = intake_fixture()
      assert {:error, %Ecto.Changeset{}} = Control.update_intake(intake, @invalid_attrs)
      assert intake == Control.get_intake!(intake.id)
    end

    test "delete_intake/1 deletes the intake" do
      intake = intake_fixture()
      assert {:ok, %Intake{}} = Control.delete_intake(intake)
      assert_raise Ecto.NoResultsError, fn -> Control.get_intake!(intake.id) end
    end

    test "change_intake/1 returns a intake changeset" do
      intake = intake_fixture()
      assert %Ecto.Changeset{} = Control.change_intake(intake)
    end
  end

  describe "outputs" do
    alias NefroControl.Control.Output

    import NefroControl.ControlFixtures

    @invalid_attrs %{timestamp: nil, type: nil, comments: nil, quantity: nil}

    test "list_outputs/0 returns all outputs" do
      output = output_fixture()
      assert Control.list_outputs() == [output]
    end

    test "get_output!/1 returns the output with given id" do
      output = output_fixture()
      assert Control.get_output!(output.id) == output
    end

    test "create_output/1 with valid data creates a output" do
      valid_attrs = %{timestamp: ~U[2024-06-11 20:22:00Z], type: "some type", comments: "some comments", quantity: 120.5}

      assert {:ok, %Output{} = output} = Control.create_output(valid_attrs)
      assert output.timestamp == ~U[2024-06-11 20:22:00Z]
      assert output.type == "some type"
      assert output.comments == "some comments"
      assert output.quantity == 120.5
    end

    test "create_output/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Control.create_output(@invalid_attrs)
    end

    test "update_output/2 with valid data updates the output" do
      output = output_fixture()
      update_attrs = %{timestamp: ~U[2024-06-12 20:22:00Z], type: "some updated type", comments: "some updated comments", quantity: 456.7}

      assert {:ok, %Output{} = output} = Control.update_output(output, update_attrs)
      assert output.timestamp == ~U[2024-06-12 20:22:00Z]
      assert output.type == "some updated type"
      assert output.comments == "some updated comments"
      assert output.quantity == 456.7
    end

    test "update_output/2 with invalid data returns error changeset" do
      output = output_fixture()
      assert {:error, %Ecto.Changeset{}} = Control.update_output(output, @invalid_attrs)
      assert output == Control.get_output!(output.id)
    end

    test "delete_output/1 deletes the output" do
      output = output_fixture()
      assert {:ok, %Output{}} = Control.delete_output(output)
      assert_raise Ecto.NoResultsError, fn -> Control.get_output!(output.id) end
    end

    test "change_output/1 returns a output changeset" do
      output = output_fixture()
      assert %Ecto.Changeset{} = Control.change_output(output)
    end
  end

  describe "events" do
    alias NefroControl.Control.Event

    import NefroControl.ControlFixtures

    @invalid_attrs %{timestamp: nil, comments: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Control.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Control.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{timestamp: ~U[2024-06-11 20:22:00Z], comments: "some comments"}

      assert {:ok, %Event{} = event} = Control.create_event(valid_attrs)
      assert event.timestamp == ~U[2024-06-11 20:22:00Z]
      assert event.comments == "some comments"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Control.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{timestamp: ~U[2024-06-12 20:22:00Z], comments: "some updated comments"}

      assert {:ok, %Event{} = event} = Control.update_event(event, update_attrs)
      assert event.timestamp == ~U[2024-06-12 20:22:00Z]
      assert event.comments == "some updated comments"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Control.update_event(event, @invalid_attrs)
      assert event == Control.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Control.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Control.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Control.change_event(event)
    end
  end
end
