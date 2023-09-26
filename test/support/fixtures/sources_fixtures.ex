defmodule Mocker.SourcesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mocker.Sources` context.
  """

  @doc """
  Generate a source.
  """
  def source_fixture(attrs \\ %{}) do
    {:ok, source} =
      attrs
      |> Enum.into(%{
        data: "some data"
      })
      |> Mocker.Sources.create_source()

    source
  end
end
