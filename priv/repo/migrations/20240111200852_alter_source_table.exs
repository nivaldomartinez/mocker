defmodule Mocker.Repo.Migrations.AddSourceError do
  use Ecto.Migration

  def change do
    alter table(:sources) do
      add :type, :string, size: 20, default: "success"
      add :statusCode, :integer, default: 200
    end
  end
end
