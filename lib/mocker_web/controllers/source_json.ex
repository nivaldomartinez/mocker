defmodule MockerWeb.SourceJSON do
  alias Mocker.Sources.Source

  @doc """
  Renders a list of sources.
  """
  def index(%{sources: sources}) do
    for(source <- sources, do: data(source))
  end

  @doc """
  Renders a single source.
  """
  def show(%{source: source}) do
    %{data: sourceString} = source
    {:ok, sourceData} = Jason.decode(sourceString)
    sourceData
  end

  def created(%{source: source}) do
    data(source)
  end

  defp data(%Source{} = source) do
    {:ok, sourceData} = Jason.decode(source.data)
    %{
      id: source.id,
      data: sourceData
    }
  end
end
