class RemoveStatusAndTotalPriceFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :status
    remove_column :orders, :total_price
  end
end
