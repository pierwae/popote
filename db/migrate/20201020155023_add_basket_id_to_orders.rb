class AddBasketIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :basket, null: false, foreign_key: true
  end
end
