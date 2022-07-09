defmodule Tutorial.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :category, Ecto.Enum, values: [:shirts, :pants, :shoes]
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :category])
    |> validate_required([:name, :category])
  end
end
