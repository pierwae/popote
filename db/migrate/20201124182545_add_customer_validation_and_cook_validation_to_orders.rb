class AddCustomerValidationAndCookValidationToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :customer_validation, :boolean
    add_column :orders, :cook_validation, :boolean
  end
end
