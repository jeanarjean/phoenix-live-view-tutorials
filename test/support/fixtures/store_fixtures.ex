defmodule Tutorial.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tutorial.Store` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        category: "some category",
        name: "some name"
      })
      |> Tutorial.Store.create_product()

    product
  end
end
