defmodule Mocker.Repo do
  use Ecto.Repo,
    otp_app: :mocker,
    adapter: Ecto.Adapters.Postgres
end
