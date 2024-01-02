defmodule MockerWeb.Router do
  use MockerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["https://mocker-front-production.up.railway.app"]
  end

  scope "/api", MockerWeb do
    pipe_through :api
    get "/", HomeController, :index

    get "/sources", SourceController, :index
    get "/sources/:id", SourceController, :show
    post "/sources", SourceController, :create
    delete "/sources/:id", SourceController, :delete
  end
end
