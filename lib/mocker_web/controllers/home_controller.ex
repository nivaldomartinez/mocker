defmodule MockerWeb.HomeController do
  use MockerWeb, :controller

  def index(conn, _params) do
    text conn, "welcome to mocker api"
  end
end
