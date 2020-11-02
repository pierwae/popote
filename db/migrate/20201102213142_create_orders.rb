class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :cook, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.string :status
      t.float :total_price
      t.date :date
      t.references :basket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
