defmodule MockerWeb.HomeController do
  use MockerWeb, :controller

  def index(conn, _params) do
    text conn, "hello world - #{Mix.env()}"
  end
end
