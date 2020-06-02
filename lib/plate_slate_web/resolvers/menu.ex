defmodule PlateSlateWeb.Resolvers.Menu do
  alias PlateSlate.Menu

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end

  def search(_, %{matching: term}, _) do
    {:ok, Menu.search(term)}
  end

  def create_item(_, %{input: params}, %{context: context}) do
    with {:ok, item} <- Menu.create_item(params) do
      {:ok, %{menu_item: item}}
    end
  end

  def get_item(_, %{id: id}, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Menu, Menu.Item, id)
    |> on_load(fn loader ->
      {:ok, Dataloader.get(loader, Menu, Menu.Item, id)}
    end)
  end
end
