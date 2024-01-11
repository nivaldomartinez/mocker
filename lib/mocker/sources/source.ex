defmodule Mocker.Sources.Source do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sources" do
    field :data, :string
    field :type, :string
    field :statusCode, :integer

    timestamps()
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [:data, :type, :statusCode])
    |> validate_required([:data])
  end
end
