defmodule MockerWeb.SourceControllerTest do
  use MockerWeb.ConnCase

  import Mocker.SourcesFixtures

  alias Mocker.Sources.Source

  @create_attrs %{
    data: "some data"
  }
  @update_attrs %{
    data: "some updated data"
  }
  @invalid_attrs %{data: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sources", %{conn: conn} do
      conn = get(conn, ~p"/api/sources")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create source" do
    test "renders source when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/sources", source: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/sources/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some data"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/sources", source: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update source" do
    setup [:create_source]

    test "renders source when data is valid", %{conn: conn, source: %Source{id: id} = source} do
      conn = put(conn, ~p"/api/sources/#{source}", source: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/sources/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some updated data"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, source: source} do
      conn = put(conn, ~p"/api/sources/#{source}", source: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete source" do
    setup [:create_source]

    test "deletes chosen source", %{conn: conn, source: source} do
      conn = delete(conn, ~p"/api/sources/#{source}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/sources/#{source}")
      end
    end
  end

  defp create_source(_) do
    source = source_fixture()
    %{source: source}
  end
end
