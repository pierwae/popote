class AddInstructionsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :instructions, :string
  end
end
