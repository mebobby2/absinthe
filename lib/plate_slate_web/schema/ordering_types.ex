defmodule PlateSlateWeb.Schema.OrderingTypes do
  use Absinthe.Schema.Notation

  input_object :order_item_input do
    field :menu_item_id, non_null(:id)
    field :quantity, non_null(:integer)
  end
  input_object :place_order_input do
    field :customer_number, :integer
    field :items, non_null(list_of(non_null(:order_item_input)))
  end

  object :order_result do
    field :order, :order
    field :errors, list_of(:input_error)
  end
  object :order do
    field :id, :id
    field :customer_number, :integer
    field :items, list_of(:order_item)
    field :state, :string
  end
  object :order_item do
    field :name, :string
    field :quantity, :integer
  end
end
