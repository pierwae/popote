class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :meal, null: false, foreign_key: true
      t.string :status
      t.float :total_price

      t.timestamps
    end
  end
end
