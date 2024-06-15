defmodule NefroControl.Control do
  @moduledoc """
  The Control context.
  """

  import Ecto.Query, warn: false
  alias NefroControl.Repo

  alias NefroControl.Control.Intake

  @doc """
  Returns the list of intakes.

  ## Examples

      iex> list_intakes()
      [%Intake{}, ...]

  """
  def list_intakes do
    Repo.all(Intake)
  end

  def list_intakes_by_date(date) do
    Intake
    |> where([i], fragment("?::date", i.timestamp) == ^date)
    |> Repo.all()
  end

  @doc """
  Gets a single intake.

  Raises `Ecto.NoResultsError` if the Intake does not exist.

  ## Examples

      iex> get_intake!(123)
      %Intake{}

      iex> get_intake!(456)
      ** (Ecto.NoResultsError)

  """
  def get_intake!(id), do: Repo.get!(Intake, id)

  @doc """
  Creates a intake.

  ## Examples

      iex> create_intake(%{field: value})
      {:ok, %Intake{}}

      iex> create_intake(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_intake(attrs \\ %{}) do
    %Intake{}
    |> Intake.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a intake.

  ## Examples

      iex> update_intake(intake, %{field: new_value})
      {:ok, %Intake{}}

      iex> update_intake(intake, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_intake(%Intake{} = intake, attrs) do
    intake
    |> Intake.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a intake.

  ## Examples

      iex> delete_intake(intake)
      {:ok, %Intake{}}

      iex> delete_intake(intake)
      {:error, %Ecto.Changeset{}}

  """
  def delete_intake(%Intake{} = intake) do
    Repo.delete(intake)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking intake changes.

  ## Examples

      iex> change_intake(intake)
      %Ecto.Changeset{data: %Intake{}}

  """
  def change_intake(%Intake{} = intake, attrs \\ %{}) do
    Intake.changeset(intake, attrs)
  end

  alias NefroControl.Control.Output

  @doc """
  Returns the list of outputs.

  ## Examples

      iex> list_outputs()
      [%Output{}, ...]

  """
  def list_outputs do
    Repo.all(Output)
  end

  def list_outputs_by_date(date) do
    Output
    |> where([i], fragment("?::date", i.timestamp) == ^date)
    |> order_by([i], asc: i.timestamp)
    |> Repo.all()
    |> Enum.drop(1)
  end

  @doc """
  Gets a single output.

  Raises `Ecto.NoResultsError` if the Output does not exist.

  ## Examples

      iex> get_output!(123)
      %Output{}

      iex> get_output!(456)
      ** (Ecto.NoResultsError)

  """
  def get_output!(id), do: Repo.get!(Output, id)

  @doc """
  Creates a output.

  ## Examples

      iex> create_output(%{field: value})
      {:ok, %Output{}}

      iex> create_output(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_output(attrs \\ %{}) do
    %Output{}
    |> Output.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a output.

  ## Examples

      iex> update_output(output, %{field: new_value})
      {:ok, %Output{}}

      iex> update_output(output, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_output(%Output{} = output, attrs) do
    output
    |> Output.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a output.

  ## Examples

      iex> delete_output(output)
      {:ok, %Output{}}

      iex> delete_output(output)
      {:error, %Ecto.Changeset{}}

  """
  def delete_output(%Output{} = output) do
    Repo.delete(output)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking output changes.

  ## Examples

      iex> change_output(output)
      %Ecto.Changeset{data: %Output{}}

  """
  def change_output(%Output{} = output, attrs \\ %{}) do
    Output.changeset(output, attrs)
  end

  alias NefroControl.Control.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end
end
