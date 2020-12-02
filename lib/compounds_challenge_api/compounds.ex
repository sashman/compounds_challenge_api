defmodule CompoundsChallengeApi.Compounds do
  @moduledoc """
  The Compounds context.
  """

  import Ecto.Query, warn: false
  alias CompoundsChallengeApi.Repo

  alias CompoundsChallengeApi.Compounds.Compound

  @doc """
  Returns the list of compounds.

  ## Examples

      iex> list_compounds()
      [%Compound{}, ...]

  """
  def list_compounds do
    Repo.all(Compound)
  end

  @doc """
  Gets a single compound.

  Raises `Ecto.NoResultsError` if the Compound does not exist.

  ## Examples

      iex> get_compound!(123)
      %Compound{}

      iex> get_compound!(456)
      ** (Ecto.NoResultsError)

  """
  def get_compound!(id), do: Repo.get!(Compound, id)

  @doc """
  Creates a compound.

  ## Examples

      iex> create_compound(%{field: value})
      {:ok, %Compound{}}

      iex> create_compound(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_compound(attrs \\ %{}) do
    %Compound{}
    |> Compound.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a compound.

  ## Examples

      iex> update_compound(compound, %{field: new_value})
      {:ok, %Compound{}}

      iex> update_compound(compound, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_compound(%Compound{} = compound, attrs) do
    compound
    |> Compound.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a compound.

  ## Examples

      iex> delete_compound(compound)
      {:ok, %Compound{}}

      iex> delete_compound(compound)
      {:error, %Ecto.Changeset{}}

  """
  def delete_compound(%Compound{} = compound) do
    Repo.delete(compound)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking compound changes.

  ## Examples

      iex> change_compound(compound)
      %Ecto.Changeset{data: %Compound{}}

  """
  def change_compound(%Compound{} = compound, attrs \\ %{}) do
    Compound.changeset(compound, attrs)
  end
end
