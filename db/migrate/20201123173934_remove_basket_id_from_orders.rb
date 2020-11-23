class RemoveBasketIdFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :basket_id
  end
end
