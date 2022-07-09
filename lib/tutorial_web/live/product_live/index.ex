defmodule TutorialWeb.ProductLive.Index do
  use TutorialWeb, :live_view

  alias Tutorial.Store
  alias Tutorial.Store.Product

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:category_filter, "All")
     |> assign(:products, list_products("All"))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Store.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Store.get_product!(id)
    {:ok, _} = Store.delete_product(product)

    {:noreply, assign(socket, :products, list_products(socket.assigns.category_filter))}
  end

  def handle_event("filter-category", %{"category" => category}, socket) do
    {:noreply,
     socket
     |> assign(:category_filter, category)
     |> assign(:products, list_products(category))}
  end

  defp list_products("All") do
    Store.list_products()
  end

  defp list_products(category_filter) do
    Store.list_products()
    |> Enum.filter(fn product ->
      {:safe, category} = html_escape(product.category)
      category == category_filter
    end)
  end
end
