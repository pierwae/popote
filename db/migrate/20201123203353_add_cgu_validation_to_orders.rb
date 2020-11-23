class AddCguValidationToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :cgu_validation, :boolean
  end
end
