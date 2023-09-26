defmodule MockerWeb.SourceController do
  use MockerWeb, :controller

  alias Mocker.Sources
  alias Mocker.Sources.Source

  action_fallback MockerWeb.FallbackController

  def index(conn, _params) do
    sources = Sources.list_sources()
    render(conn, :index, sources: sources)
  end

  def create(conn, %{"source" => source_params}) do
    with {:ok, %Source{} = source} <- Sources.create_source(source_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/sources/#{source}")
      |> render(:created, source: source)
    end
  end

  def show(conn, %{"id" => id}) do
    source = Sources.get_source!(id)
    render(conn, :show, source: source)
  end

  def update(conn, %{"id" => id, "source" => source_params}) do
    source = Sources.get_source!(id)

    with {:ok, %Source{} = source} <- Sources.update_source(source, source_params) do
      render(conn, :show, source: source)
    end
  end

  def delete(conn, %{"id" => id}) do
    source = Sources.get_source!(id)

    with {:ok, %Source{}} <- Sources.delete_source(source) do
      send_resp(conn, :no_content, "")
    end
  end
end
